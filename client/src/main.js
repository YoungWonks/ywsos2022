import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import "bootstrap";
// import "bootstrap/dist/css/bootstrap.min.css";
import "../scss/custom.scss";
import axios from 'axios';
import "bootstrap-icons/font/bootstrap-icons.css";

axios.defaults.baseURL = 'http://localhost:8000'
axios.defaults.beforeRedirect

const app = createApp(App);

app.use(router);

app.mount("#app");
