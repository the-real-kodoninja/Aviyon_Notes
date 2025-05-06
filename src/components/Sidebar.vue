<template>
  <aside v-if="isSidebarOpen" class="w-1/4 bg-gray-800/50 backdrop-blur-md border-r border-gray-700/50 p-4 overflow-y-auto transition-all duration-300">
    <h2 class="text-2xl font-inter text-transparent bg-clip-text bg-gradient-to-r from-neon-purple to-neon-cyan mb-4 tracking-wide">File Explorer</h2>
    <div id="file-tree" class="space-y-2">
      <div v-for="file in files" :key="file.path" class="file-tree-item cursor-pointer p-2 hover:bg-gray-700/50 rounded transition-all" @click="loadFile(file.path)">
        {{ file.name }}
      </div>
    </div>
  </aside>
</template>

<script>
import { ref, onMounted } from 'vue'
import { useStore } from '../store'

export default {
  setup() {
    const store = useStore()
    const files = ref([])
    const isSidebarOpen = store.isSidebarOpen

    onMounted(() => {
      // Fallback files if server fails
      files.value = [
        { name: 'Aviyon Notes', path: 'Aviyon Corporation dd1f156f667e4272b706350d65fdc267.md' }
      ]
    })

    const loadFile = (path) => store.loadFile(path)

    return { files, isSidebarOpen, loadFile }
  }
}
</script>

<style scoped>
.file-tree-item.active {
  background: linear-gradient(to right, rgba(191, 0, 255, 0.3), rgba(0, 255, 240, 0.3));
  font-weight: bold;
}
</style>
