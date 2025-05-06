import { defineStore } from 'pinia'
import { useLocalStorage } from '@vueuse/core'
import { openDB } from 'idb-keyval'

export const useStore = defineStore('main', {
  state: () => ({
    isSidebarOpen: true,
    content: useLocalStorage('aviynotes-content', '# Aviyon Notes\nWelcome!'),
    files: [],
    logs: [],
    db: null,
  }),
  actions: {
    async initDB() {
      this.db = await openDB('aviynotes', 1, {
        upgrade(db) {
          db.createObjectStore('notes')
        },
      })
    },
    async saveNote() {
      if (this.db) await this.db.put('notes', this.content, 'default')
      this.logs.push('Note saved')
    },
    loadFile(path) {
      this.content = `# ${path}\nContent loaded from ${path}`
      this.logs.push(`Loaded: ${path}`)
    },
    updateContent(html) {
      this.content = html
    },
    toggleSidebar() {
      this.isSidebarOpen = !this.isSidebarOpen
    },
    getDoc() {
      return { type: 'doc', content: [{ type: 'paragraph', content: [{ type: 'text', text: this.content }] }] }
    },
    getContent() {
      return this.content
    },
  },
  getters: {
    activeFile: (state) => state.files.find(f => f.active),
  },
})
