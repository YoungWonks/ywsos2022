<script setup>
import { RouterLink, RouterView } from "vue-router";
import Navbar from "./components/Navbar.vue";
</script>

<template>
<div class="d-flex flex-column justify-content-start align-items-start min-vh-100">
  <Navbar/>
  <RouterView />
</div>
</template>


<style>
body{
  background-position-y: -200px !important;
  background-size: 100% auto !important;
  background: url(./Flower_field.jpg);
}
</style>