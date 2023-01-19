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
        />
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="exampleCheck1" />
        <label class="form-check-label" for="exampleCheck1">Remember me</label>
      </div>
      <button type="submit" class="btn btn-secondary m-3">Submit</button>
      <a href = "/login">
        <button class="btn btn-secondary">Login instead</button>
      </a>
    </form>
  </div>
</template>

<script>
export default {
  data(){
    return{username:""}
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
  }
};
</script>
