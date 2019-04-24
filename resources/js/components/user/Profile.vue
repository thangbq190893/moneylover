<template>
    <div class=" mt-5 row">
        <div class="col-sm-3  mx-auto">
            <img :src="'/image/'+img" alt="" class=" imgcustom">
            <button class="btn-primary" @click="editPhoto">
                <i class="fas fa-plus-circle">&nbsp; Edit photo</i>
            </button>
        </div>

        <table class="table col-md-7 mx-auto">
            <tbody>
            <tr>
                <th class="">Full Name</th>
                <td class="font-italic blue">{{name}}</td>
            </tr>
            <tr>
                <th class="">Email</th>
                <td class="font-italic blue">{{email}}</td>
            </tr>
            </tbody>
        </table>
        <div class="col-md-12" align="center">
            <h2 class="blue font-weight-light">Tai san hien co</h2>
            <p class="font-weight-bold" v-if="currencies.VND !== 0">{{currencies.VND | formatMoney}} <i
                    class="red">VND</i></p>
            <p class="font-weight-bold" v-if="currencies.BRL !== 0">{{currencies.BRL | formatMoney}} <i
                    class="red">BRL</i></p>
            <p class="font-weight-bold" v-if="currencies.CNY !== 0">{{currencies.CNY | formatMoney}} <i
                    class="red">CNY</i></p>
            <p class="font-weight-bold" v-if="currencies.EUR !== 0">{{currencies.EUR | formatMoney}} <i
                    class="red">EUR</i></p>
            <p class="font-weight-bold" v-if="currencies.GBP !== 0">{{currencies.GBP | formatMoney}} <i
                    class="red">GBP</i></p>
            <p class="font-weight-bold" v-if="currencies.JPY !== 0">{{currencies.JPY | formatMoney}} <i
                    class="red">JPY</i></p>
            <p class="font-weight-bold" v-if="currencies.USD !== 0">{{currencies.USD | formatMoney}} <i
                    class="red">USD</i></p>
        </div>
        <div class="modal fade" id="editPhoto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <h5 class="modal-title text-center blue"> Edit Photo</h5>
                    <div class="card-body">
                        <form @submit="formSubmit" enctype="multipart/form-data ">
                            <strong>Image:</strong>
                            <div class="">
                                <img :src="url" v-if="url" class="previewImage">
                            </div>
                            <div class="">
                                <input type="file"
                                       class="form-control"
                                       v-on:change="onImageChange"
                                       name="image"
                                       id="myInput">
                                <p class="red">{{errors.img}}</p>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-success">Submit</button>
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import EventBus from '../EventBus.vue'

    export default {
        name: "Profile",
        data() {
            return {
                //upload photo
                image: '',
                url: '',
                errors: {
                    img: '',
                },
                // money details
                currencies: {
                    VND: 0,
                    USD: 0,
                    GBP: 0,
                    EUR: 0,
                    CNY: 0,
                    JPY: 0,
                    BRL: 0,
                },
                token: window.$cookies.get('token'),
                name: '',
                email: '',
                img: '',
                API: axios.create({
                    headers: {
                        'Authorization': 'Bearer ' + window.$cookies.get('token')
                    },
                    timeout: 999999
                })
            }
        },

        mounted() {
            if (window.$cookies.get('token')) {
                this.getWallet();
            }
            this.getProfile();
        },

        methods: {
            getProfile() {
                this.API.get('/api/profile').then((res) => {
                    this.name = res.data.name;
                    this.email = res.data.email;
                    this.img = res.data.photo;
                })
            },

            getWallet() {
                this.API.get('/api/wallet').then((response) => {
                    let wls = response.data;
                    if (wls) {
                        wls.forEach(element => {
                                if (element.currency_name == 'VNĐ') {
                                    this.currencies.VND = this.currencies.VND + parseInt(element.pay)
                                }
                                if (element.currency_name == 'USD') {
                                    this.currencies.USD = this.currencies.USD + parseInt(element.pay)
                                }
                                if (element.currency_name == 'GBP') {
                                    this.currencies.GBP = this.currencies.GBP + parseInt(element.pay)
                                }
                                if (element.currency_name == 'EUR') {
                                    this.currencies.EUR = this.currencies.EUR + parseInt(element.pay)
                                }
                                if (element.currency_name == 'CNY') {
                                    this.currencies.CNY = this.currencies.CNY + parseInt(element.pay)
                                }
                                if (element.currency_name == 'JPY') {
                                    this.currencies.JPY = this.currencies.JPY + parseInt(element.pay)
                                }
                                if (element.currency_name == 'BRL') {
                                    this.currencies.BRL = this.currencies.BRL + parseInt(element.pay)
                                }
                            }
                        )
                    }

                })
            },

            editPhoto() {

                this.url = '';
                document.getElementById('myInput').value = '';
                this.errors.img = '';
                this.image = '';
                $('#editPhoto').modal('show');
            },

            onImageChange(e) {
                this.image = e.target.files[0];
                this.url = URL.createObjectURL(this.image);
            },

            formSubmit(e) {
                e.preventDefault();
                this.errors.img = '';
                let formData = new FormData();
                formData.append('image', this.image);
                if (!this.image) {
                    this.errors.img = 'image not found';
                } else if (this.image.type == 'image/png' || this.image.type == 'image/jpeg' || this.image.type == 'image/jpg') {
                    this.API.post('/api/uploadImg', formData)
                        .then((response) => {

                            this.img = response.data.image;
                            EventBus.$emit('img', this.img);
                        })
                        .catch(function (error) {
                                this.output = error;
                            }
                        );

                    $('#editPhoto').modal('hide');
                } else {
                    this.errors.img = 'not image';
                }
            }
        }
    }
</script>

<style scoped>
    .imgcustom {
        width: 200px;
        height: 200px;
    }
    .previewImage {
        width: 200px;
        height: 200px;
    }
</style>
