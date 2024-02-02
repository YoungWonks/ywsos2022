<template>
  <div class="d-flex align-self-center flex-column bg-white bg-opacity-50 p-5 rounded-3">
    <form>
      <div class="mb-3">
        <label for="exampleInputEmail1" class="form-label">Email address/username</label>
        <input type="text" class="form-control" :class="[validateUsername?'is-valid':'is-invalid']" id="exampleInputEmail1" aria-describedby="emailHelp" v-model = "username"/>
        <div class = "invalid-feedback" v-show = "!validateUsername">
          <p>
            Username is invalid. Usernames must be 3 characters long.
          </p>
        </div>
        <div id="emailHelp" class="form-text">
          We'll never share your email with anyone else.
        </div>
      </div>
      <div class="mb-3">
        <label for="exampleInputPassword1" class="form-label">Password</label>
        <input
          type="password"
          class="form-control"
          id="exampleInputPassword1"
          v-model = "password"
        />
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="exampleCheck1" />
        <label class="form-check-label" for="exampleCheck1">Remember me</label>
      </div>
      <button type="button" class="btn btn-secondary m-3" id="register_button" @click="register">Submit</button>
      <a href = "/login">
        <button class="btn btn-secondary" type="button"><a href="/login" class="text-decoration-none text-white">Login instead</a></button>
      </a>
    </form>
    <br>
    <br>
    <div v-if='response!=""' class="alert alert-danger" role="alert">
    {{response}}
  </div>
  </div>
  <div>
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
    register(){
      let globalThis = this
      console.log('register',this.username,this.password)
      axios.post('http://127.0.0.1:8000/api/auth/register', {
    username: this.username,
    password: this.password
  })
  // "this" doesn't work in the then of the axios.post becuase there is no context (use globalThis)
  .then(function (response) {
    globalThis.response=response.data.content;
    if (response.data.content == 'success'){
      router.push("/login")}
    console.log(response); 
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
