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
import Donut from 'vue-css-donut-chart';
import 'vue-css-donut-chart/dist/vcdonut.css';
import Datetime from 'vue-datetime';
import 'vue-datetime/dist/vue-datetime.css';
import money from 'v-money';

Vue.use(Donut);
Vue.use(VueCookies);
VueCookies.config(30000);
Vue.use(Datetime);
Vue.use(money,{precision: 4});
Vue.filter('formatMoney', function (value) {
    let val = (value / 1).toFixed(2).replace('.', ',');
    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')
});
Vue.prototype.$http = Axios.create({
    baseURL: 'http://127.0.0.1:8000',
    headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + window.$cookies.get('token')
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

