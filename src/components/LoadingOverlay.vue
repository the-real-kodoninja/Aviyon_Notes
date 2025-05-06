<template>
  <div id="loading-overlay" class="absolute inset-0 bg-gray-900/90 flex items-center justify-center z-50">
    <div class="text-center">
      <h2 class="text-3xl font-inter text-neon-cyan mb-4 animate-pulse">Initializing Aviyon Notes...</h2>
      <div class="w-64 bg-gray-800 rounded-full h-4 overflow-hidden">
        <div id="progress-bar" class="bg-gradient-to-r from-neon-purple to-neon-cyan h-full transition-all duration-300" :style="{ width: progress + '%' }"></div>
      </div>
      <p id="progress-text" class="text-neon-purple mt-2 text-lg">{{ progress }}%</p>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, onUnmounted } from 'vue'

export default {
  setup() {
    const progress = ref(0)
    let interval

    onMounted(() => {
      interval = setInterval(() => {
        if (progress.value < 100) progress.value += 1
        else clearInterval(interval)
      }, 20)
    })

    onUnmounted(() => clearInterval(interval))

    return { progress }
  }
}
</script>
