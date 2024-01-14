import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import axios from "axios";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: "/error",
      name: "error",
      component: () => import("../views/ErrorView.vue"),
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/LoginView.vue"),
    },
    {
      path: "/create",
      name: "create",
      component: () => import("../views/CreateView.vue"),
    },
    {
      path: "/register",
      name: "register",
      component: () => import("../views/RegisterView.vue"),
    },
    {
      path: "/settings",
      name: "settings",
      component: () => import("../views/SettingsView.vue"),
    },
    {
      path: "/forgotpass",
      name: "forgotPass",
      component: () => import("../views/ForgotPassView.vue"),
    },
    {
      path: "/dashboard",
      name: "dashboard",
      component: () => import("../views/DashView.vue"),
    },
    {
      path: "/stats",
      name: "stats",
      component: () => import("../views/StatsView.vue"),
    },
  ],
});

let publicRoutes = ['/login', '/register', '/', '/error']; 

router.beforeEach(async (to, from, next)=>{
  console.log(!(publicRoutes.includes(window.location.pathname)));
  console.log(to, from, next);
  // window.location.href=to.fullPath;
  if(publicRoutes.includes(window.location.pathname)){
    next();
  }
  else{
    console.log('not public!');
    console.log(localStorage.getItem('access_token'));
    console.log(localStorage.getItem('refresh_token'));
    let access_token = localStorage.getItem('access_token');
    let response = await axios.get('/api/auth/access-token', {
      headers: {
          'Authorization': `Bearer ${access_token}`,
      }
    })
    console.log(response);
    if (response.status==200){
      next();
    }
    else{
      console.log('response failed!');
    }
    // .then(function (response) {
    //   // handle success
    //   console.log(response);
    //   next();
    // })
    // .catch(function (error) {
    //   // handle error
    //   console.log(error);
    //   // window.location.href='/error';
    // }); 
  }
//   if (!(publicRoutes.includes(window.location.pathname))){
//     let access_token = localStorage.getItem('access_token');
//     axios.get('/api/auth/access-token', {
//       headers: {
//           'Authorization': `Bearer ${access_token}`,
//       }
//     })
//     .then(function (response) {
//       // handle success
//       console.log(response);
//     })
//     .catch(function (error) {
//       // handle error
//       console.log(error);
//       window.location.href='/error';
//     }); 
// }
})



export default router;
