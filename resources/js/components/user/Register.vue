<template>
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <form v-on:submit.prevent="checkform" method="post">
                    <h1 class="h3 mb-3 font-weight-normal">
                        Register
                    </h1>
                    <div class="form-group">
                        <label for="first_name">First name</label>
                        <input id="first_name" type="text" class="form-control" v-model="first_name" name="first_name"
                               placeholder="Enter first_name">
                        <p class="red">{{errors.firstname}}</p>
                    </div>
                    <div class="form-group">
                        <label for="last_name">Last name</label>
                        <input id="last_name" type="text" class="form-control" v-model="last_name" name="last_name"
                               placeholder="Enter last_name">
                        <p class="red">{{errors.lastname}}</p>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input id="email" type="email" class="form-control" v-model="email" name="email"
                               placeholder="Enter Email">
                        <p class="red">{{errors.email}}</p>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input id="password" type="password" class="form-control" v-model="password" name="password"
                               placeholder="Enter Password">
                        <p class="red">{{errors.password}}</p>
                    </div>
                    <div class="form-group">
                        <label for="c_password">Confirm Password</label>
                        <input id="c_password" type="password" class="form-control" v-model="c_password"
                               name="c_password"
                               placeholder="Enter Password">
                        <p class="red">{{errors.c_password}}</p>
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
                errors: {
                    firstname:"",
                    lastname: "",
                    email: "",
                    password: "",
                    c_password:""
                },
                first_name: "",
                last_name: "",
                email: "",
                password: "",
                c_password: ""
            }
        },

        methods: {
            checkform() {
                this.errors.firstname="";
                this.errors.lastname="";
                this.errors.email="";
                this.errors.password= "";
                this.errors.c_password="";
                if (!this.first_name) {
                    this.errors.firstname='First Name is required'
                }
                if (!this.last_name) {
                    this.errors.lastname="Last Name is required"
                }
                if (!this.email){
                    this.errors.email= "Email is required"
                }
                if (!this.password) {
                    this.errors.password="Password is required"
                }
                if (this.password.length < 5) {
                    this.errors.password= "password more than 5 characters"
                }
                if (!this.c_password || this.c_password !== this.password) {
                    this.errors.c_password= "Your password and confirm password don't match"
                }
                if (!(this.errors.firstname || this.errors.lastname || this.errors.password || this.errors.c_password)) {
                    axios.post('/api/register', {
                        name: this.first_name + " " + this.last_name,
                        email: this.email,
                        password: this.password,
                        c_password: this.c_password
                    })
                        .then((res) => {
                            if (!res.data.token) {
                                alert(' Nguoi dung da ton tai')
                            } else {
                                this.$router.push({name: 'login'})
                            }
                        })
                        .catch((err) => {
                        });
                }
            },
        }
    }
</script>

<style scoped>
.errors{
    padding-top: 200px;
}
</style>
