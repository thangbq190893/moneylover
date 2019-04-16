<template>
    <div class="container container-fluid row charts">
        <div class="col-md-6">
            <h2 class="blue">Select Wallet to show charts</h2>
            <select  @click="getIdWallet($event)">
                <option value="">Choose Wallet</option>
                <option v-for="(wallet,id) in wallets" :key="id" :value="wallet.id">{{wallet.name}}</option>
            </select>

        </div>
        <vc-donut  foreground="grey"
                  :size="200" unit="px" :thickness="30"
                  has-legend legend-placement="bottom"
                  :sections="sections" class="col-md-6" :total="100"
        default-slot></vc-donut>
    </div>

</template>

<script>
    export default {
        name: "DonutChart",
        data() {
            return {
                intro: 10,
                wallet_id: 0,
                wallets:[],
                cash: 0,
                DEBT_LOAN: 0,
                EXPENSE: 0,
                INCOME: 0,
                FREE: 0,
                total: 0,
                sections:
                    [
                        {label: 'DEBT&LOAN', value: 0, color: 'green'},
                        {label: 'EXPENSE', value: 0, color: 'red'},
                        {label: 'INCOME', value: 0, color: 'blue'},
                        {label: 'FREE', value: 0, color: 'gray'}
                    ],
                API: axios.create({
                    headers: {
                        'Authorization': 'Bearer ' + window.$cookies.get('token')
                    },
                    timeout: 999999
                })
            };
        },
        mounted() {
            this.getWallet();
        },
        methods: {
            getWallet(){
              this.API.get('/api/wallet')
                  .then((response)=> {
                      this.wallets = response.data;
                  })
            },
            getIdWallet(event) {
                if (window.$cookies.get('token')){
                    this.wallet_id = event.target.value;
                    this.DEBT_LOAN = 0;
                    this.EXPENSE =0;
                    this.INCOME =0;
                    if (this.wallet_id==0){
                        this.sections[0].value=0;
                        this.sections[1].value=0;
                        this.sections[2].value=0;
                        this.sections[3].value=0;
                    } else {
                        this.getValueTransaction();
                        this.getValueWallet();
                    }
                } else {
                    this.$router.push('login')
                }

            },
            getValueTransaction() {
                this.API.get('/api/wallet/'+ this.wallet_id+'/transactions')
                    .then((res) => {
                            let transactions = res.data;

                            if (transactions) {
                                transactions.forEach(element => {
                                    if (element.category_id == 1) {
                                        this.DEBT_LOAN = this.DEBT_LOAN + parseFloat(element.cost);
                                    } else if (element.category_id == 2) {
                                        this.EXPENSE = this.EXPENSE + parseFloat(element.cost);
                                    } else {
                                        this.INCOME = this.INCOME + parseFloat(element.cost);
                                    }
                                });
                            }
                        }
                    );
            },
            getValueWallet() {
                this.API.get('/api/wallet/' + this.wallet_id)
                    .then((res) => {
                            this.cash = res.data.cash;
                            if ((parseFloat(res.data.cash) + this.DEBT_LOAN + this.INCOME) < this.EXPENSE) {
                                this.total = this.DEBT_LOAN + this.INCOME + this.EXPENSE;
                                this.sections[0].value = (this.DEBT_LOAN / this.total) * 100;
                                this.sections[2].value = (this.INCOME / this.total) * 100;
                                this.sections[1].value = 100 - this.sections[0].value - this.sections[2].value;
                                this.sections[3].value = 0;
                            } else {
                                this.total = parseFloat(res.data.cash) + this.DEBT_LOAN + this.INCOME + this.EXPENSE;
                                this.sections[0].value = (this.DEBT_LOAN / this.total) * 100;
                                this.sections[1].value = (this.EXPENSE / this.total) * 100;
                                this.sections[2].value = (this.INCOME / this.total) * 100;
                                this.sections[3].value = 100 - this.sections[0].value - this.sections[1].value - this.sections[2].value;
                            }
                        }
                    )
            }

        }
    }
</script>

<style scoped>
.intro {
    width: 40px;
    height: 20px;
}
    .charts{
        padding-top: 30px;
    }
</style>
