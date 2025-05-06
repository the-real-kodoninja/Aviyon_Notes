<template>
  <header class="bg-gray-800/50 backdrop-blur-md border-b border-gray-700/50 p-4 flex justify-between items-center sticky top-0 z-10">
    <h1 class="text-4xl font-inter text-transparent bg-clip-text bg-gradient-to-r from-neon-purple to-neon-cyan animate-pulse">Aviyon Notes</h1>
    <div class="flex space-x-4">
      <button @click="saveNote" class="px-4 py-2 bg-neon-purple/50 hover:bg-neon-purple text-white rounded-lg shadow-lg neon-glow transition-all duration-300">Save</button>
      <button @click="newNote" class="px-4 py-2 bg-neon-cyan/50 hover:bg-neon-cyan text-white rounded-lg shadow-lg neon-glow transition-all duration-300">New Note</button>
      <button @click="toggleSidebar" class="px-4 py-2 bg-gray-700/50 hover:bg-gray-600 text-white rounded-lg">Toggle Sidebar</button>
    </div>
  </header>
</template>

<script>
import { useStore } from '../store'
import { useRouter } from 'vue-router'

export default {
  setup() {
    const store = useStore()
    const router = useRouter()

    const saveNote = () => store.saveNote()
    const newNote = () => router.push('/new')
    const toggleSidebar = () => store.toggleSidebar()

    return { saveNote, newNote, toggleSidebar }
  }
}
</script>

<style scoped>
.neon-glow {
  box-shadow: 0 0 10px rgba(191, 0, 255, 0.5), 0 0 20px rgba(0, 255, 240, 0.5);
}
</style>
