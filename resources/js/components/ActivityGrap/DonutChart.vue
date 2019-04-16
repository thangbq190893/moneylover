<template>
    <div>
        {{value0}} / {{value1}} / {{value2}} / {{value3}}/ {{total}}
        {{sections[0].value}} / {{sections[1].value}} / {{sections[2].value}} / {{sections[3].value}}
        <vc-donut :sections="sections">50%</vc-donut>
    </div>

</template>

<script>
    export default {
        name: "DonutChart",
        data() {
            return {
                // transactions: [],
                value0: 0,
                value1: 0,
                value2: 0,
                value3: 0,
                total:0,
                sections:
                    [
                        { label: 'DEBT&LOAN', value: 0, color: 'red' },
                        { label: 'EXPENSE', value: 0, color: 'green' },
                        { label: 'INCOME', value: 0, color: 'blue' },
                        { label: 'FREE', value: 0, color: 'whrite' }
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
            this.API.get('/api/wallet/1/transactions')
                .then((res) => {
                        let transactions = res.data;

                        if (transactions) {
                            transactions.forEach(element => {
                                if (element.category_id == 1) {
                                    this.value0 = this.value0 + parseFloat(element.cost);
                                } else if (element.category_id == 2) {
                                    this.value1 = this.value1 + parseFloat(element.cost);
                                } else {
                                    this.value2 = this.value2 + parseFloat(element.cost);
                                }
                            });
                        }
                    }
                );
            this.API.get('/api/wallet/1')
                .then((res) => {
                    console.log(res.data)
                    this.total = parseFloat(res.data.cash) + this.value0 + this.value2;
                    this.value3 = this.total - this.value1;
                    this.sections[0].value= (this.value0/this.total)*100;
                    this.sections[1].value= (this.value1/this.total)*100;
                    this.sections[2].value= (this.value2/this.total)*100;
                    this.sections[3].value= (this.value3/this.total)*100;
                })
        }
    }
</script>

<style scoped>

</style>
