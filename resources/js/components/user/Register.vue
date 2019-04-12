<template>
    <div class="container">
        <div class="row">
            <div class="col-md-6 mt-5 mx-auto">
                <form v-on:submit.prevent="checkform" method="post">
                    <h1 class="h3 mb-3 font-weight-normal">
                        Register
                    </h1>
                    <div class="form-group">
                        <label for="first_name">First name</label>
                        <input id="first_name" type="text" class="form-control" v-model="first_name" name="first_name"
                               placeholder="Enter first_name">
                    </div>
                    <div class="form-group">
                        <label for="last_name">Last name</label>
                        <input id="last_name" type="text" class="form-control" v-model="last_name" name="last_name"
                               placeholder="Enter last_name">
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
                    <div class="form-group">
                        <label for="c_password">Re-Password</label>
                        <input id="c_password" type="password" class="form-control" v-model="c_password"
                               name="c_password"
                               placeholder="Enter Password">
                    </div>
                    <button class="btn btn-lg btn-primary btn-block">Register</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        data() {
            return {
                errors: [],
                first_name: "",
                last_name: "",
                email: "",
                password: "",
                c_password: ""
            }
        },

        methods: {
            checkform() {
                this.errors = [];
                if (!this.first_name) {
                    this.errors.push("First Name is required");
                }
                if (!this.last_name) {
                    this.errors.push("Last Name is required")
                }
                if (!this.password) {
                    this.errors.push("Password is required")
                }
                if (this.password.length < 5) {
                    this.errors.push("password more than 5 characters")
                }
                if (!this.c_password || this.c_password !== this.password) {
                    this.errors.push("Password is fails")
                }
                if (!this.errors.length) {
                    axios.post('/api/register', {
                        name: this.first_name + " " + this.last_name,
                        email: this.email,
                        password: this.password,
                        c_password: this.c_password
                    })
                        .then((res) => {
                            if (!res.data.token){
                                alert(' Nguoi dung da ton tai')
                            } else{
                                this.$router.push({name: 'login'})
                            }
                        })
                        .catch((err) => {
                            console.log(err)
                        });
                }else {
                    alert(this.errors[0])
                }
            },
        }
    }
</script>

<style scoped>

</style>
