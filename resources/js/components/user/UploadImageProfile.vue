<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card card-default">
                    <div class="card-header">File Upload Component</div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3" v-if="image">
                                <img :src="image" class="img-responsive" height="70" width="90">
                            </div>
                            <div class="col-md-6">
                                <input type="file" v-on:change="onImageChange" class="form-control">
                            </div>
                            <div class="col-md-3">
                                <button class="btn btn-success btn-block" @click="uploadImage">Upload Image</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                image: '',
                API: axios.create({
                    headers: {
                        'Authorization': 'Bearer ' + window.$cookies.get('token')
                    },
                    timeout: 999999
                })
            }
        },
        methods: {
            onImageChange(e) {
                let files = e.target.files[0];
                this.createImage(files.name);
                console.log(this.createImage(files.name));
            },
            createImage(file) {
                let reader = new FileReader();
                let vm = this;
                reader.onload = (e) => {
                    vm.image = e.target.result;
                };
                reader.readAsDataURL(file);
            },
            uploadImage() {
                this.API.patch('/uploadImg', {image: this.image}).then(response => {
                    console.log(response.data);
                });
            }
        }
    }
</script>
