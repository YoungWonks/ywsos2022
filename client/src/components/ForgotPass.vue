<template>
    <div class="d-flex align-self-center flex-column bg-white bg-opacity-50 p-5 rounded-3">
        <h2 class="mb-3">Forgot password?</h2>
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
            We'll never share your information with anyone else.
          </div>
        </div>
        <div class="mb-3">
          <label for="exampleInputPassword1" class="form-label">New Password</label>
          <input
            type="password"
            class="form-control"
            id="exampleInputPassword1"
            v-model = "new_password"
          />
        </div>
        <div class="mb-3">
          <label for="secretKeyInput" class="form-label">Secret Key</label>
          <p>(the six letter string that was given to you at signup)</p>
          <input
            type="password"
            class="form-control"
            id="secretKeyInput"
            v-model = "key"
          />
        </div>
        <div class="mb-3 form-check">
          <input type="checkbox" class="form-check-input" id="exampleCheck1" />
        </div>
        <button type="button" class="btn btn-secondary m-3" @click="forgotpass">Submit</button>
        <a href = "/login">
          <button class="btn btn-secondary">Login instead</button>
        </a>
      </form>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  import router from '../router';
  export default {
    data(){
      return{username:"",password:"",key:""}
    },
    methods:{
      forgotpass(){
        console.log('forgotpass',this.username,this.password,this.key)
        axios.post('http://127.0.0.1:8000/api/auth/forgotpass', {
      username: this.username,
      new_password: this.password,
      key: this.key
    })
    .then(function (response) {
      if (response.data.content == 'success'){
        router.push("/settings")}
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
  