console.log 'aviyon_notes.coffee loaded - immediate log'

document.addEventListener 'DOMContentLoaded', ->
  console.log 'DOMContentLoaded event fired'

  fileTree = document.getElementById 'file-tree'
  editor = document.getElementById 'editor'
  terminal = document.getElementById 'terminal'
  saveBtn = document.getElementById 'save-btn'
  newNoteBtn = document.getElementById 'new-note-btn'
  loadingOverlay = document.getElementById 'loading-overlay'
  mainContent = document.getElementById 'main-content'
  progressBar = document.getElementById 'progress-bar'
  progressText = document.getElementById 'progress-text'

  console.log 'fileTree:', fileTree
  console.log 'editor:', editor
  console.log 'terminal:', terminal
  console.log 'saveBtn:', saveBtn
  console.log 'newNoteBtn:', newNoteBtn
  console.log 'loadingOverlay:', loadingOverlay
  console.log 'mainContent:', mainContent
  console.log 'progressBar:', progressBar
  console.log 'progressText:', progressText

  # Simulate progress and show main content immediately
  progress = 0
  progressInterval = setInterval ->
    if progress < 100
      progress += 1
      progressBar.style.width = "#{progress}%"
      progressText.textContent = "#{progress}%"
    if progress >= 100
      clearInterval progressInterval
      console.log 'Hiding loading overlay and showing main content...'
      setTimeout ->
        if loadingOverlay
          loadingOverlay.classList.add 'animate__animated', 'animate__fadeOut'
        if mainContent
          mainContent.classList.remove 'hidden'
          mainContent.classList.add 'animate__animated', 'animate__fadeIn'
          console.log 'Main content should now be visible'
      , 500
  , 20 # Faster progress for testing (100% in ~2 seconds)

  # Load default file after showing main content
  defaultFile = 'Aviyon Corporation dd1f156f667e4272b706350d65fdc267.md'
  setTimeout ->
    console.log 'Loading default file:', defaultFile
    loadFile defaultFile
  , 2500 # Delay to ensure UI is visible first

  # Attempt to build file tree (non-blocking)
  setTimeout ->
    console.log 'Fetching file list from Rust server...'
    fetch('http://127.0.0.1:8080/docs/files')
      .then (response) ->
        console.log 'Fetch response:', response
        response.json()
      .then (files) ->
        console.log 'Fetched files:', files
        files.forEach (file) ->
          item = document.createElement 'div'
          item.className = 'file-tree-item cursor-pointer'
          item.textContent = file.name
          item.dataset.path = file.path
          item.addEventListener 'click', -> loadFile file.path
          if file.path is defaultFile
            item.classList.add 'active'
          fileTree.appendChild item
      .catch (error) ->
        console.error 'Fetch error:', error
        terminal.innerHTML += "<div>Error loading file tree: #{error}</div>"
  , 3000 # Delay to ensure UI is visible first

  loadFile = (path) ->
    console.log 'Loading file:', path
    fetch("http://127.0.0.1:8080/docs/#{encodeURI path}")
      .then (response) ->
        console.log 'Load file response:', response
        response.text()
      .then (markdown) ->
        console.log 'Loaded markdown:', markdown
        editor.value = markdown
        document.querySelectorAll('.file-tree-item').forEach (item) -> item.classList.remove 'active'
        document.querySelector(".file-tree-item[data-path=\"#{path}\"]")?.classList.add 'active'
        terminal.innerHTML += "<div>Loaded: #{path}</div>"
      .catch (error) ->
        console.error 'Load file error:', error
        terminal.innerHTML += "<div>Error loading #{path}: #{error}</div>"
        # Fallback content if file fails to load
        editor.value = '# Aviyon Notes\nFailed to load file. Start editing here...'

  saveBtn.addEventListener 'click', ->
    path = document.querySelector('.file-tree-item.active')?.dataset.path or 'new_note.md'
    console.log 'Saving file:', path
    fetch "http://127.0.0.1:8080/docs/save/#{encodeURI path}",
      method: 'POST'
      headers: 'Content-Type': 'application/json'
      body: JSON.stringify(content: editor.value)
    .then (response) ->
      console.log 'Save response:', response
      response.text()
    .then (msg) ->
      console.log 'Save message:', msg
      terminal.innerHTML += "<div>#{msg}</div>"
    .catch (error) ->
      console.error 'Save error:', error
      terminal.innerHTML += "<div>Error saving: #{error}</div>"

  newNoteBtn.addEventListener 'click', ->
    console.log 'Creating new note'
    editor.value = '# New Note\nStart here...'
    terminal.innerHTML += '<div>Created new note</div>'
