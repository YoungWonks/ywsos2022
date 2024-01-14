<template>
  <div class="d-flex align-self-center flex-column bg-white bg-opacity-50 p-5 rounded-3">
    <form>
      <div class="mb-3">
        <label for="username" class="form-label">Username</label>
        <input type="text" class="form-control" id="username" aria-describedby="emailHelp" v-model="username"/>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <input
          type="password"
          class="form-control"
          id="password"
          v-model="password"
        />
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="exampleCheck1" />
        <label class="form-check-label" for="exampleCheck1">Remember me</label>
      </div>
      <button type="button" class="btn btn-secondary m-3" id="login_button" @click="login">Login</button>
        <!-- take the tokens and store in the browser, then redirect to stats, then check in the router.beforeEach if there is a token in the local
        storage. if there isn't redirect to login (maybe add an error message) -->
        <button class="btn btn-secondary" type="button"><a href="/register" class="text-decoration-none text-white">Sign up instead</a></button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import router from '../router';
export default {
  data(){
    return{username:"",password:"",response:""}
  },
  methods:{
    login(){
      let globalThis = this
      console.log('login', this.username)
      axios.post('http://127.0.0.1:8000/api/auth/login', {
    username: this.username,
    password: this.password
  })
  // "this" doesn't work in the then of the axios.post becuase there is no context (use globalThis)
  .then(function (response) {
    globalThis.response=response.data.content;
    console.log(response.data);
    if (response.data.content == 'success'){
      console.log(response.data.username); 
      localStorage.setItem("username", response.data.username);
      localStorage.setItem("access_token", response.data.access_token);
      localStorage.setItem("refresh_token", response.data.refresh_token);
      window.location.href="/stats";}
  })
  .catch(function (error) {
    console.log(error);
  });
    }
  },
  computed:{
    validateUsername(){
      if (this.username.length < 3){
        return false
      }
      else{
        return true
      }
    }
  },
  
  
};
</script>

