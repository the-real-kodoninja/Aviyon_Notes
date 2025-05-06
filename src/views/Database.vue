<template>
  <div class="bg-gray-800/50 backdrop-blur-md border border-gray-700/50 rounded-lg p-4 h-[calc(100vh-12rem)] overflow-y-auto">
    <h2 class="text-2xl font-inter text-transparent bg-clip-text bg-gradient-to-r from-neon-purple to-neon-cyan mb-4">Database View</h2>
    <p class="text-gray-200">This is a placeholder for Notion-like database views (Kanban, Table, Calendar, etc.). Coming soon!</p>
    <div class="mt-4">
      <button @click="switchView('kanban')" class="px-4 py-2 bg-neon-purple/50 hover:bg-neon-purple text-white rounded-lg mr-2">Kanban</button>
      <button @click="switchView('table')" class="px-4 py-2 bg-neon-cyan/50 hover:bg-neon-cyan text-white rounded-lg">Table</button>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'

export default {
  setup() {
    const currentView = ref('kanban')

    const switchView = (view) => {
      currentView.value = view
      console.log(`Switched to ${view} view`)
    }

    return { currentView, switchView }
  }
}
</script>
