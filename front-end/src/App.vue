<script setup>
import Navbar from './components/NavbarView.vue'
</script>

<template>
  <div>
    <Navbar />
    
    <main>
      <RouterView />
    </main>
  </div>
</template>