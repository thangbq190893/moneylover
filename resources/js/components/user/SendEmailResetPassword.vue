<template>
    <div class="container" style="padding-right: 250px; text-decoration: none">
        <h3 class=" message">{{message}}</h3>
        <div class="justify-content-center row">
            <form v-on:submit.prevent="resetPassword()" method="post" autocomplete="off" >
                <h3 class="mb-3 font-weight-normal blue" >
                    Please fill your email !
                </h3>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input id="email" type="email" class="form-control" v-model="email" name="email"
                           placeholder="Enter Email">
                </div>
                <button class="btn btn-lg btn-primary btn-block">Send Email</button>
            </form>
        </div>
        <br>

        <div>
            <h5 class="row justify-content-center">
                <router-link class="" tag="a" v-bind:to="{name: 'login'}">---Back to Login---</router-link>
            </h5>
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
                        if (response.data == 404) {
                            this.message = 'Email not found. '
                        }
                        if (response.data == 200) {
                            this.message = 'We have e-mailed your password reset link!'
                        }
                    })
                    .catch((error) => {
                        }
                    );
            }
        }
    }
</script>

<style scoped>
    .message {
        margin-top: 50px;
        text-align: center;
        color: red;
    }
</style>
