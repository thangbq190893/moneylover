<template>
    <div class=" mt-5 row">
        <div class="col-sm-3  mx-auto">
            <img :src="'/img/imgCustom/'+img" alt="" class="img-thumbnail">
            <router-link to="/uploadImg">
                <div class=" imgProfile">
                    <input type="file" @change="onFileSelected">
                    <button @click="onUpload">Upload</button>
                </div>
            </router-link>
        </div>
        <table class="table col-md-7 mx-auto">
            <tbody>
            <tr>
                <th class="">Full Name</th>
                <td class="font-italic blue">{{name}}</td>
            </tr>
            <tr>
                <th class="">Email</th>
                <td class="font-italic blue">{{email}}</td>
            </tr>
            </tbody>
        </table>
        <div class="col-md-12" align="center">
            <h2 class="blue font-weight-light">Tai san hien co</h2>
            <p class="font-weight-bold" v-if="currencies.VND !== 0">{{currencies.VND | formatMoney}}  <i class="red">VND</i></p>
            <p class="font-weight-bold" v-if="currencies.BRL !== 0">{{currencies.BRL | formatMoney}}  <i class="red">BRL</i></p>
            <p class="font-weight-bold" v-if="currencies.CNY !== 0">{{currencies.CNY | formatMoney}}  <i class="red">CNY</i></p>
            <p class="font-weight-bold" v-if="currencies.EUR !== 0">{{currencies.EUR | formatMoney}}  <i class="red">EUR</i></p>
            <p class="font-weight-bold" v-if="currencies.GBP !== 0">{{currencies.GBP | formatMoney}}  <i class="red">GBP</i></p>
            <p class="font-weight-bold" v-if="currencies.JPY !== 0">{{currencies.JPY | formatMoney}}  <i class="red">JPY</i></p>
            <p class="font-weight-bold" v-if="currencies.USD !== 0">{{currencies.USD | formatMoney}}  <i class="red">USD</i></p>
        </div>

    </div>
</template>

<script>
    export default {
        name: "Profile",
        data() {
            return {
                currencies: {
                    VND: 0,
                    USD: 0,
                    GBP: 0,
                    EUR: 0,
                    CNY: 0,
                    JPY: 0,
                    BRL: 0,
                },
                token: window.$cookies.get('token'),
                name: window.$cookies.get('name'),
                email: window.$cookies.get('email'),
                img: window.$cookies.get('img'),
                wallets: [],
                API: axios.create({
                    headers: {
                        'Authorization': 'Bearer ' + window.$cookies.get('token')
                    },
                    timeout: 999999
                })
            }
        },
        mounted() {
            this.getWallet();
        },
        methods: {
            getWallet() {
                this.API.get('/api/wallet').then((response) => {
                    let wls = response.data;
                    if (wls){
                        wls.forEach(element => {
                                if (element.currency_name == 'VNĐ') {
                                    this.currencies.VND= this.currencies.VND + parseInt(element.pay)
                                }
                                if (element.currency_name == 'USD') {
                                    this.currencies.USD= this.currencies.USD + parseInt(element.pay)
                                }
                                if (element.currency_name == 'GBP') {
                                    this.currencies.GBP= this.currencies.GBP + parseInt(element.pay)
                                }
                                if (element.currency_name == 'EUR') {
                                    this.currencies.EUR= this.currencies.EUR + parseInt(element.pay)
                                }
                                if (element.currency_name == 'CNY') {
                                    this.currencies.CNY= this.currencies.CNY + parseInt(element.pay)
                                }
                                if (element.currency_name == 'JPY') {
                                    this.currencies.JPY= this.currencies.JPY + parseInt(element.pay)
                                }
                                if (element.currency_name == 'BRL') {
                                    this.currencies.BRL= this.currencies.BRL + parseInt(element.pay)
                                }
                            }
                        )
                    }

                })
            }
        }
    }
</script>

<style scoped>
.imgcustom {
    width: 200px;
    height: 150px;
}
</style>
