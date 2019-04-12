<template >
    <div class="container container-fluid" style="width: 600px; height: 800px">
        <line-chart :charData="data" :option="options"></line-chart>
    </div>

</template>

<script>
    import LineChart from './LineChart.js'
    import axios from 'axios'
    export default {
        name: "ActivityGrap",
        components:{
            "line-chart" : LineChart
        },
        data () {
            return {
                data: {
                    labels: ['cho', 'meo', 'ga'],
                    datasets: [
                        {
                            label: 'Data One',
                            backgroundColor: '#f87979',
                            data: [40, 20, 30]
                        },
                        {
                            label: 'Data One',
                            backgroundColor: 'blue',
                            data: [20, 40, 30]
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        yAxes: [{
                            ticks: {
                                suggestedMin: 0
                            }
                        }]
                    }
                },
                API:axios.create({
                    headers: {
                        'Authorization': 'Bearer ' + window.$cookies.get('token')
                    },
                    timeout: 999999
                }),
                idWallet: 1,
                money: []
            }
        },
        mounted() {
            this.API.get('/api/wallet/'+this.idWallet+'/transactions')
                .then((res)=> {
                    this.money = res.data;
                })
        }
    }
</script>

<style scoped>

</style>
