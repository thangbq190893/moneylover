<template>
    <div class="container container-fluid" style=" padding-right: 200px; padding-top: 70px">
        <div class="justify-content-center row" >
            <form v-on:submit.prevent="login()" method="post" autocomplete="off">
                <div>
                    <h3 class="blue" style="text-align: center">Log in</h3>
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input id="email" type="email" class="form-control" v-model="email" name="email"
                           placeholder="Enter Email">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input id="password" type="password" class="form-control" v-model="password" name="password"
                           placeholder="Enter Password">
                </div>
                <button class="btn btn-lg btn-primary btn-block">Sign in</button>
            </form>
        </div>
        <br>
        <div>
            <p class="row justify-content-center">
                <router-link tag="a" v-bind:to="{name: 'forgot-password'}">Forgot password</router-link>
            </p>
        </div>
        <br>
        <div>
            <h5 class="row justify-content-center">
                Don't have an Account? please register &nbsp; &nbsp;
                <router-link class="btn btn-sm btn-primary" tag="button" v-bind:to="{name: 'register'}">Register</router-link>
            </h5>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    import EventBus from '../EventBus.vue'

    export default {
        name: "login",
        data() {
            return {
                email: '',
                password: ''
            }
        },

        methods: {
            login() {
                axios.post('/api/login', {
                    email: this.email,
                    password: this.password
                })
                    .then((res) => {
                        const token = res.data.token;
                        if (token == null) {
                            alert("user name or password is incorrect");
                            this.$router.push({name: 'login'})
                        } else {
                            window.$cookies.set('token', token);
                            EventBus.$emit('token', token);
                            this.email = '';
                            this.password = '';
                            axios.get('/api/profile', {
                                headers: {
                                    'Authorization': 'Bearer ' + token
                                }
                            })
                                .then((response) => {
                                    let name = response.data.name;
                                    let img = response.data.photo;
                                    EventBus.$emit('name', name);
                                    EventBus.$emit('img', img);
                                    this.$router.push({name: 'chart'});
                                });
                        }
                    })
                    .catch((err) => {
                    });
            },
        },
    }
</script>

<style scoped>

</style>
