import {Bar, mixins} from 'vue-chartjs'
const reactiveProp= mixins;
export default {
    extends: Bar,
    mixins: [reactiveProp],
    props: {
      charData: Object,
       option: Object
      },
    mounted() {
        // this.chartData is created in the mixin.
        // If you want to pass options please create a local options object
        this.renderChart(this.charData, this.option)
    }
}
