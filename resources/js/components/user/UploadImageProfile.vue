<template>
    <div class=" imgProfile">
        <input type="file" @change="onFileSelected">
        <button @click="onUpload">Upload</button>
    </div>
</template>

<script>
    export default {
        name: "UploadImageProfile",
        data() {
            return {
                selectedFile: null,
                API: axios.create({
                    headers: {
                        'Authorization': 'Bearer ' + window.$cookies.get('token')
                    },
                    timeout: 999999
                })
            }
        },
        methods: {
            onFileSelected(event) {
                this.selectedFile = event.target.files[0];
                console.log(this.selectedFile)
            },
            onUpload() {
                const params = {
                    'photo': this.selectedFile.name
                };
                this.API.patch('/api/uploadImg', params, {
                    onUploadProgress: uploadEvent => {
                        console.log('Upload progress: ' + Math.round(uploadEvent.loaded / uploadEvent.total * 100) + '%');
                    }
                }).then((res) => {
                    console.log(res.data)
                })
            }
        }
    }
</script>

<style scoped>

</style>
