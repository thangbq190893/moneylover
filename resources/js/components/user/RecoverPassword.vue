<template>
    <div>
        <p>{{message}}</p>
        <form action="" @submit.prevent="createNewPassword()">
            <ul>
                <li>New password
                    <input type="password" v-model="password">
                    {{errors.password}}
                </li>
                <li>Confirm password
                    <input type="password" v-model="password_confirmation">
                    {{errors.password_confirmation}}
                </li>
            </ul>
            <button type="submit">create new password</button>
        </form>
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