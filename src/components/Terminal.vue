<template>
  <div class="mt-4 bg-gray-900/70 backdrop-blur-md border border-gray-700/50 rounded-lg p-4 h-32 overflow-y-auto">
    <div id="terminal" class="text-green-400"></div>
  </div>
</template>

<script>
import { useStore } from '../store'

export default {
  setup() {
    const store = useStore()
    return { logs: store.logs }
  }
}
</script>
