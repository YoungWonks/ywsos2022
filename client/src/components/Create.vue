<style scoped>
  .text-wrapper {
    --space: 5px;
    margin-top: var(--space);
    margin-bottom: var(--space);
  }
</style>
<template>
    <br>
        <div id="vueApp" class="d-flex justify-content-center">
            <div id="uploadForm" class="container-fluid">
                <form enctype="multipart/form-data" @submit="formSubmit" class="sign-up-grad py-4" @input="saveForm">
                    <div class="form-group my-2">
                        <input type="text" v-model="title" id="title" placeholder="Title" class="form-control" required>
                    </div>
                    <div class="form-group my-2">
                        <input type="text" v-model="des" id="desc" placeholder="Description" class="form-control" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group col my-2">
                            <input v-model="lat" id="lat" placeholder="Latitude" class="form-control" required>
                        </div>
                        <div class="form-group col my-2">
                            <input v-model="long" id="long" placeholder="Longitude" class="form-control" required>
                        </div>
                    </div>
                    <button @click="getPosition" type="button" class="btn btn-primary my-2">
                        <i class="bi bi-pin-map-fill"></i>
                    </button>
                    <br>
                    <button class="btn btn-primary btn-block my-2" @click="formSubmit()" id="submit" type="button" name="submit">
                        Submit
                    </button>
                </form>
            </div>
            <div class="alert alert-info formsubmit" style="height: 60px; display: none" role="alert">
                <p>[[ msg ]]</p>
                <button type="button" style="padding: 0 0.5rem" class="btn btn-danger close" data-dismiss="alert" onClick="$('.formsubmit').css({'display': 'none'});">
                    <i class="bi bi-x-lg"></i>
                </button>
            </div>
        </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        title: localStorage.getItem("title") || "",
        des: localStorage.getItem("desc") || "",
        long: localStorage.getItem("long") || 0,
        lat: localStorage.getItem("lat") || 0,
        username: localStorage.getItem("username") || "Anonymous",
      };
    },
    methods: {
      formSubmit() {
        // var datasubmit = {
        //   title: this.title,
        //   des: this.des,
        //   position: [this.lat, this.long],
        // };
  
        // function postImage(callback) {
        //   axios.post("/api/posts", formdata, {
        //     contentType: false,
        //     processData: false,
        //     success: callback,
        //   });
        // }
  
        // function postData(result) {
        // datasubmit["filename"] = result.filename;
        console.log("inside form submit");
          axios.post("/api/posts", {
            title: this.title,
            text: this.des,
            coords: [this.long, this.lat],
            username: this.username,
          }, (data) => {
            $(".formsubmit").removeClass("alert-danger");
            $(".formsubmit").addClass("alert-success");
            $(".formsubmit").css({ display: "flex" });
            console.log("Form successfully submitted");
            app.msg = "Form successfully submitted";
            localStorage.removeItem("title");
            localStorage.removeItem("desc");     
            localStorage.removeItem("lat"); 
            localStorage.removeItem("long");
            localStorage.removeItem("type");  
          }, {
            error: () => {
              $(".formsubmit").removeClass("alert-success");
              $(".formsubmit").addClass("alert-danger");
              $(".formsubmit").css({ display: "flex" });
              app.msg = "Invalid coordinates. Please try again.";
            },
          });
        }

        // postImage(postData);
      },
      getPosition() {
        navigator.geolocation.getCurrentPosition((pos) => {
          this.lat = pos.coords.latitude;
          this.long = pos.coords.longitude;
          this.saveForm();
        });
      },
      saveForm() {
        localStorage.setItem("title", this.title);
        localStorage.setItem("desc", this.des);
        localStorage.setItem("lat", this.lat);
        localStorage.setItem("long", this.long);
        localStorage.setItem("type", this.type);
      },
    };
  </script>
  
  