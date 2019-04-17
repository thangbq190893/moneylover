import Vue from 'vue';
import Router from 'vue-router';
import Login from './components/user/Login.vue';
import Register from './components/user/Register.vue';
import ManagerWallet from './components/ManagerWallet/ManagerWallet.vue'
import Transaction from './components/ManagerWallet/Transactions.vue'
import DonutChart from './components/ActivityGrap/DonutChart.vue';
import Profile from './components/user/Profile.vue';

Vue.use(Router);

const router = new Router({
    mode: 'history',
    routes:[
        {
            path: '/login',
            name: 'login',
            component: Login
        },
        {
            path: '/register',
            name: 'register',
            component: Register
        },
        {
            path: '/profile',
            name: 'profile',
            component: Profile,
            meta: { requiresAuth: true }
        }
        , {
            path: '/manager-wallet',
            name: 'manager-wallet',
            component: ManagerWallet,
            meta: { requiresAuth: true }
        },{
            path: '/wallet/:id',
            name: 'transactions',
            component: Transaction,
            meta: { requiresAuth: true }
        },{
            path: '/chart',
            name: 'chart',
            component: DonutChart,
            meta: { requiresAuth: true }
        },
    ],
});
router.beforeEach((to, from, next) => {
    if (to.meta.requiresAuth) {
        const token = window.$cookies.get('token');
        if (token) {
            next()
        }else{
            next({name: 'login'})
        }
    }
    next()
});
export default router
