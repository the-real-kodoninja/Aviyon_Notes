use actix_web::{get, post, web, App, HttpResponse, HttpServer, Responder};
use actix_cors::Cors;
use serde::{Deserialize, Serialize};
use std::fs;
use std::path::Path;

#[derive(Serialize)]
struct FileEntry {
    name: String,
    path: String,
}

#[get("/docs/files")]
async fn list_files() -> impl Responder {
    let mut files = vec![];
    let docs_path = Path::new("public/docs/");
    if let Ok(entries) = fs::read_dir(docs_path) {
        for entry in entries.filter_map(|e| e.ok()) {
            if let Some(file_name) = entry.file_name().to_str() {
                if file_name.ends_with(".md") {
                    files.push(FileEntry {
                        name: file_name.to_string(),
                        path: entry.path().to_string_lossy().into_owned(),
                    });
                }
            }
        }
    }
    HttpResponse::Ok().json(files)
}

#[get("/docs/{path:.*}")]
async fn get_file(path: web::Path<String>) -> impl Responder {
    let file_path = format!("public/docs/{}", path.as_str());
    match fs::read_to_string(&file_path) {
        Ok(content) => HttpResponse::Ok().body(content),
        Err(_) => HttpResponse::NotFound().body("File not found"),
    }
}

#[derive(Deserialize)]
struct SaveRequest {
    content: String,
}

#[post("/docs/save/{path:.*}")]
async fn save_file(path: web::Path<String>, req: web::Json<SaveRequest>) -> impl Responder {
    let file_path = format!("public/docs/{}", path.as_str());
    match fs::write(&file_path, &req.content) {
        Ok(_) => HttpResponse::Ok().body("File saved successfully"),
        Err(_) => HttpResponse::InternalServerError().body("Failed to save file"),
    }
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        let cors = Cors::default()
            .allowed_origin("http://localhost:8000")
            .allowed_methods(vec!["GET", "POST"])
            .allowed_headers(vec!["Content-Type"])
            .max_age(3600);

        App::new()
            .wrap(cors)
            .service(list_files)
            .service(get_file)
            .service(save_file)
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await
}
