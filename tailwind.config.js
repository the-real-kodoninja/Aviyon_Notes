/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'neon-purple': '#bf00ff',
        'neon-cyan': '#00fff0',
      },
    },
  },
  plugins: [],
}
