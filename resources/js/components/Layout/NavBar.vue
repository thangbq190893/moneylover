<template>
    <!-- Navbar -->
    <nav class="nav main-header navbar navbar-expand navbar-light border-bottom " style="width: auto">
        <!-- Left navbar links -->
        <ul v-if="token" class="nav navbar-nav">
            <li  class="nav-item" >
                <a  class="nav-link" data-widget="pushmenu" href="#"><i class="fa fa-bars"></i></a>
            </li>
            <li class="red" >
                <h1 ><b>Chào mừng bạn đến với MoneyLover </b></h1>
            </li>
        </ul>
        <h3 v-if="!token" class="nav-item col-lg-9 red justify-content-center" >
            <h2>Chào mừng bạn đến với MoneyLover</h2>
        </h3>
    </nav>
    <!-- /.navbar -->
</template>

<script>
    import EventBus from '../EventBus.vue'
    export default {
        name: "NavBar",
        data() {
            return {
                token: window.$cookies.get('token'),
            }
        },
        mounted(){
            EventBus.$on('name', (status) => {
                this.name = status;
            });
            EventBus.$on('token', (token) => {
                this.token = token;
            })
        }
    }
</script>

<style scoped>
nav{
    background-color: #f2c3c3;
}
.btn-success{
    border: #4c110f solid 2px ;
}
</style>
