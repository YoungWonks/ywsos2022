<template>
  <FAQ />
  <br>
    <footer class="d-flex justify-content-center container-fluid">
    <p class="col-md-4 mb-0 text-body-secondary">© 2023 Cleanworld</p>

    <a href="/" class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
      <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
    </a>

    <ul class="nav col-md-4 justify-content-end">
      <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Home</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Open Source Repository</a></li>
      <li class="nav-item">support.cleanworld@googlemail.com</li>
    </ul>
  </footer>
  <br>
</template>

<script>
import Register from "../components/Register.vue";
export default {
  components: {
    FAQ,
  },
};
</script>
