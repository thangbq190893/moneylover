<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="card-body col-md-3">
                <vue-dropzone ref="myVueDropzone" id="dropzone"
                              :options="dropzoneOptions"
                              :useCustomSlot=true
                              @vdropzone-complete="afterComplete">
                    <img :src="'/images/'+img" alt="" class=" imgcustom">
                </vue-dropzone>
            </div>
        </div>
    </div>
</template>

<script>

    import vue2Dropzone from 'vue2-dropzone'
    import 'vue2-dropzone/dist/vue2Dropzone.min.css'

    export default {
        components: {
            vueDropzone: vue2Dropzone
        },
        data: function () {
            return {
                img: '',
                API: axios.create({
                    headers: {
                        'Authorization': 'Bearer ' + window.$cookies.get('token')
                    },
                    timeout: 999999
                }),
                dropzoneOptions: {
                    url: '/api/upload',
                    thumbnailWidth: 150,
                    addRemoveLinks: true,
                    headers: {
                        "X-CSRF-TOKEN": document.head.querySelector("[name=csrf-token]").content,
                        'Authorization': 'Bearer ' + window.$cookies.get('token')
                    }
                }
            }
        },
        mounted() {
            console.log('Component mounted.');
            this.getProfile();
        },
        methods: {
            getProfile() {
                this.API.get('/api/profile').then((response) => {
                    this.img = response.data.photo;
                })
            },
            afterComplete(file) {
                console.log(file);
            }

        }
    }
</script>

<style scoped>
    .imgcustom {
        width: 200px;
        height: 200px;
        margin: -2em;
    }

    #dropzone {
        width: 200px;
        height: 200px;
        padding: 0;
    }

</style>
