<template>
    <div class="container">
        <p class="bg-success red">{{message}}</p>
        <div class="justify-content-center row">
            <form action="" @submit.prevent="createNewPassword()">
                <div class="form-group">
                    <label for="password">New password</label>
                    <input id="password" type="password" class="form-control" v-model="password">
                    {{errors.password}}
                </div>
                <div class="form-group">
                    <label for="confirmationpassword">Confirm password</label>
                    <input id="confirmationpassword" type="password" class="form-control"
                           v-model="password_confirmation">
                    {{errors.password_confirmation}}
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit">create new password</button>
            </form>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        name: "RecoverPassword",

        data() {
            return {
                'token': this.$route.params.token,
                'email': '',
                'password': '',
                'password_confirmation': '',
                'message': '',
                'errors': {
                    'password': '',
                    'password_confirmation': ''
                }
            }
        },

        mounted() {
            this.getDataUser();
        },

        methods: {
            getDataUser() {
                this.message = '';
                axios.get('/api/password/find/' + this.token)
                    .then((response) => {
                        this.email = response.data.email
                    })
                    .catch((error) => {
                            if (error.response) {
                                if (error.response.status == 404) {
                                    this.message = error.response.data.message;
                                }
                                if (error.response.status == 422) {
                                    this.message = error.response.data.email[0];
                                }
                            }
                        }
                    );
            },

            createNewPassword() {
                this.message = '';
                this.errors.password = '';
                this.errors.password_confirmation = '';
                if (this.password.length < 6) {
                    this.errors.password = 'password must be at least 6 characters';
                }
                if (this.password_confirmation !== this.password) {
                    this.errors.password_confirmation = 'password confirm not match';
                }
                if (!(this.errors.password || this.errors.password_confirmation)) {
                    let params = {
                        'email': this.email,
                        'token': this.token,
                        'password': this.password,
                        'password_confirmation': this.password_confirmation
                    };
                    axios.post('/api/password/reset', params)
                        .then((response) => {
                            if (response.data) {
                                this.message = 'changed password success'
                            }
                        })
                        .catch((error) => {
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
                            }
                        );
                }

            }
        }
    }
</script>

<style scoped>

</style>
