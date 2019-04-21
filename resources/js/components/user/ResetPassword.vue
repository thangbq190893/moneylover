<template>
    <div class="container">
        <div class="justify-content-center row">
            <p>{{message}}</p>
            <form v-on:submit.prevent="resetPassword()" method="post" autocomplete="off">
                <h1 class="h3 mb-3 font-weight-normal text-white">
                    <i> Please fill your email !</i>
                </h1>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input id="email" type="email" class="form-control" v-model="email" name="email"
                           placeholder="Enter Email">
                </div>
                <button class="btn btn-lg btn-primary btn-block">Forgot password</button>
            </form>
        </div>
        <br>

        <div>
            <h3 class="row justify-content-center">
                <router-link class="btn-success" tag="button" v-bind:to="{name: 'login'}">Login</router-link>
            </h3>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';

    export default {
        name: "ResetPassword",
        data() {
            return {
                'email': '',
                'message': ''
            }
        },
        methods: {
            resetPassword() {
                this.message = '';
                let params = {
                    'email': this.email
                };
                axios.post('/api/password/create', params)
                    .then((response) => {
                        this.message = response.data.message;
                        console.log(response.data);
                    })
                    .catch((error) => {
                        // Error
                        if (error.response) {
                            // The request was made and the server responded with a status code
                            // that falls out of the range of 2xx
                            if (error.response.status == 404) {
                                this.message = error.response.data.message;
                                console.log('error.message', error.response.data.message);
                                console.log('status', error.response.status);
                            }
                            if (error.response.status == 422) {
                                this.message = error.response.data.email[0];
                                console.log('errors.email', error.response.data.email[0]);
                                console.log('status', error.response.status);
                            }
                        }
                    });
            }
        }
    }
</script>

<style scoped>

</style>
