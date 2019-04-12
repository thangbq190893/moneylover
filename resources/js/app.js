
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');
import App from './components/App.vue';
import router from './router.js';
import Axios from 'axios';
import VueCookies from 'vue-cookies';

Vue.use(VueCookies);
VueCookies.config('7d');
Vue.filter('formatMoney', function (value) {
    let val = (value/1).toFixed(2).replace('.', ',')
    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')
});

Vue.prototype.$http = Axios.create({
    baseURL: 'http://127.0.0.1:8000',
    headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + localStorage.token
    },
    timeout: 999999
});
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

new Vue({
    el: '#app',
    router,
    render: h => h(App)
});

