<template>
    <div>
        <!-- Main Sidebar Container -->
        <aside v-if="!token" class="main-sidebar sidebar-dark-primary elevation-4" id="aside1" >

        </aside>
    <!-- Main Sidebar Container -->
    <aside v-if="token" class="main-sidebar sidebar-dark-primary elevation-4">
        <p>{{name}}</p>
        <!-- Brand Logo -->
        <a href="" class="brand-link">
            <img src="/img/imgCustom/icon.png" alt="MoneyLover Logo" class="brand-image img-circle elevation-3"
                 style="opacity: .8">
            <span class="brand-text font-weight-light">Money Lover</span>
        </a>

        <!-- Sidebar -->
        <div class="sidebar">
            <!-- Sidebar user panel (optional) -->
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="image">
                    <img src="/img/imgCustom/profile.png" class="img-circle elevation-2" alt="User Image">
                </div>
                <div class="info">
                    <a href="#" class="d-block">
                        {{name}}
                    </a>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <nav  class="mt-2">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview"
                    role="menu" data-accordion="false">
                    <!-- Add icons to the links using the .nav-icon class
                         with font-awesome or any other icon font library -->
                    <li class="nav-item">
                        <router-link  to="/dashboard" class="nav-link">
                            <i class="nav-icon fas fa-tachometer-alt blue"></i>
                            <p>
                                Dashboard
                            </p>
                        </router-link>
                    </li>

                    <li class="nav-item has-treeview">
                        <router-link to="/manager-wallet" class="nav-link menu-open">
                            <i class="nav-icon fas fa-cog pink"></i>
                            <p>
                                Management
                                <i class="right fa fa-angle-left"></i>
                            </p>
                        </router-link>
                        <ul class="nav nav-treeview ">
                            <li class="nav-item">
                                <router-link tag="a" to="/manager-wallet" class="nav-link active">
                                    <i class="fa fa-circle-o nav-icon"></i>
                                    <p>Wallet</p>
                                </router-link>
                            </li>
                            <li class="nav-item">
                                <router-link tag="a" to="/chart" class="nav-link active">
                                    <i class="fa fa-circle-o nav-icon"></i>
                                    <p>Inactive Page</p>
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-user pink"></i>
                            <p>
                                Profile
                            </p>
                        </a>
                    </li>
                    <li v-if="name" class="nav-item ">
                        <a class="nav-link" href="" v-on:click="logout()">
                            <i class="nav-icon fas fa-power-off orange">Logout</i>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>
    </div>
</template>

<script>
    import EventBus from '../EventBus.vue'
    export default {
        data(){
            return {
                name: localStorage.name,
                token: window.$cookies.get('token'),
                email: "",
                id: ""
            }
        },
        mounted() {
            EventBus.$on('name', (name) => {
                this.name = name;
            })
            EventBus.$on('token', (token)=> {
                this.token = token;
            })

        },
        methods: {
            logout() {
                window.$cookies.remove('id');
                window.$cookies.remove('name');
                window.$cookies.remove('email');
                window.$cookies.remove('created_at');
                window.$cookies.remove('token');
                this.$router.push({path:'/login'})
            },
        },
        watch: {
            token(newValue){
                window.$cookies.set('token',newValue);
                this.token = window.$cookies.get('token');
            }
        },

    }
</script>

<style scoped>
#aside1{
    background-image: url("/img/imgCustom/sidebar.jpg");
}
</style>
