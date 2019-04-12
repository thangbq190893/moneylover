<template>
    <div class="content row" >
            <router-link tag="button" v-for="(wl,id) in wallets" :key="id"
                         :to="{name: 'transactions',params: {id:wl.id}}" class="col-md-4 bg-orange">
                <div class="row justify-content-between">
                    <img src="/img/imgCustom/wallet.png" alt="" class="col-md-4 ">
                    <div class="col-md-8">
                        <h4> {{wl.name}}</h4>
                        <p>Total: {{ formatPrice(wl.cash)}} {{wl.currency_name}}</p>
                        <p>Current Money: {{formatPrice(wl.pay)}} {{wl.currency_name}} </p>
                    </div>
                </div>
            </router-link>
    </div>
</template>

<script>
    import Wallets from './DashBoard.vue'
    import axios from 'axios'
    export default {
        components: {
            'wallet': Wallets
        },
        data() {
            return {
                getValue: "",
                wallets: [],
            }
        },
        mounted() {
            var API = axios.create({
                headers: {
                    'Authorization': 'Bearer ' + window.$cookies.get('token')
                },
                timeout: 999999
            });
            API.get('/api/wallet').then(response => {
                this.wallets = response.data;
            });
        },
        methods: {
            formatPrice(value){
                let val = (value/1).toFixed(2).replace('.', ',')
                return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.')
            }
        }
    }
</script>

<style scoped>
button{
    background-color: orchid !important;
    border-radius: 10px !important;
    border: 3px solid #BADA55 !important;
}
    img{
        width: 20%;
        height: 20%;
    }
</style>
