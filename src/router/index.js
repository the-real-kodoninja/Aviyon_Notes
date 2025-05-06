import { createRouter, createWebHistory } from 'vue-router'
import Editor from '../views/Editor.vue'
import Database from '../views/Database.vue'

const routes = [
  { path: '/', component: Editor },
  { path: '/database', component: Database },
  { path: '/new', component: Editor },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
