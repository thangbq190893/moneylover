<template>
    <div id="root">
        <nav-bar></nav-bar>
        <side-bar></side-bar>
        <div class="content-wrapper">
            <div class="content">
                <router-view></router-view>
            </div>
        </div>
        <main-footer></main-footer>
    </div>
</template>

<script>
    import NavBar from './Layout/NavBar'
    import SideBar from './Layout/SideBar'
    import MainFooter from './Layout/MainFooter'
    export default {
        components:{
            "nav-bar": NavBar,
            "side-bar": SideBar,
            "main-footer": MainFooter,
        }
    }
</script>

<style scoped>
.content{
    /*background-image: url("/img/imgCustom/background.jpg");*/
}
</style>
