<template>
  <div class="flex min-h-screen bg-gray-900 text-gray-200 relative overflow-hidden">
    <div class="absolute inset-0 starry-bg pointer-events-none"></div>
    <Header />
    <div class="flex flex-1">
      <Sidebar />
      <main class="flex-1 p-6">
        <router-view v-slot="{ Component }">
          <transition name="fade" mode="out-in">
            <component :is="Component" />
          </transition>
        </router-view>
      </main>
    </div>
    <Terminal />
    <LoadingOverlay v-if="isLoading" />
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import Header from './components/Header.vue'
import Sidebar from './components/Sidebar.vue'
import Terminal from './components/Terminal.vue'
import LoadingOverlay from './components/LoadingOverlay.vue'

export default {
  components: { Header, Sidebar, Terminal, LoadingOverlay },
  setup() {
    const isLoading = ref(true)

    onMounted(() => {
      setTimeout(() => {
        isLoading.value = false
      }, 2000) // Simulate initial load
    })

    return { isLoading }
  }
}
</script>

<style scoped>
.starry-bg {
  background: radial-gradient(circle, rgba(0, 255, 240, 0.1) 1px, transparent 1px);
  background-size: 20px 20px;
}
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>
