<template>
  <div class="bg-gray-800/50 backdrop-blur-md border border-gray-700/50 rounded-lg p-4 h-[calc(100vh-12rem)] overflow-y-auto">
    <editor-content :editor="editor" />
    <div v-if="isCollaborating" class="mt-4 text-neon-cyan">Collaborating with others...</div>
  </div>
</template>

<script>
import { Editor, EditorContent } from '@tiptap/vue-3'
import StarterKit from '@tiptap/starter-kit'
import Collaboration from '@tiptap/extension-collaboration'
import CollaborationCursor from '@tiptap/extension-collaboration-cursor'
import { useStore } from '../store'
import { WebSocket } from 'websocket'

export default {
  components: { EditorContent },
  setup() {
    const store = useStore()
    const editor = ref(null)
    const isCollaborating = ref(false)

    onMounted(() => {
      editor.value = new Editor({
        extensions: [
          StarterKit,
          Collaboration.configure({
            document: store.getDoc(),
          }),
          CollaborationCursor.configure({
            provider: new WebSocketProvider('ws://localhost:8080', 'aviynotes'),
          }),
        ],
        content: store.getContent() || '# Aviyon Notes\nWelcome to the ultimate note-taking platform!',
        onUpdate: () => store.updateContent(editor.value.getHTML()),
      })
      isCollaborating.value = true
    })

    onUnmounted(() => {
      editor.value.destroy()
    })

    return { editor, isCollaborating }
  }
}
</script>
