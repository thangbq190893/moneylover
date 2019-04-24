<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-9">
                <div class=" card card-default">
                    <div class="card-header"> Example component</div>
                    <div class=" card-body">
                        <div class="uploader"
                             @dragenter="OnDragEnter"
                             @dragleave="OnDragLeave"
                             @dragover.prevent
                             @drop="OnDrop"
                             :class="{dragging : isDragging}">
                            <i class="fa fa-cloud-upload"></i>
                            <p>Drag your images here</p>
                            <div>Or</div>
                            <div class="file-input">
                                <label for="file">Select a file</label>
                                <input type="file" id="file" @change="onInputChange" multiple>
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
        name: "uploader",
        data() {
            return {
                isDragging: false,
                dragCount : 0

            }
        },
        methods: {
            OnDragEnter(e) {
                e.preventDefault();

                this.dragCount++;
                this.isDragging = true;
            },
            OnDragLeave(e) {
                e.preventDefault();

                this.dragCount--;

                if(this.dragCount <= 0){
                    this.isDragging = false;
                }

            },
            onInputChange(e) {
                console.log(e);
            },
            OnDrop(e) {
                e.preventDefault();
                e.stopPropagation();

                this.isDragging = false;
                const files = e.dataTransfer.files;

                console.log(files);
            }
        }
    }
</script>

<style scoped lang="scss">
    .uploader {
        width: 100%;
        background: #2196F3;
        color: #fff;
        padding: 40px 15px;
        text-align: center;
        border-radius: 10px;
        border: 3px dashed #fff;
        font-size: 20px;
        position: relative;

        &.dragging {
            background: #fff;
            color: #2196F3;
            border: 3px dashed #2196F3;

            .file-input label {
                background: #2196F3;
                color: #fff;
            }
        }

        i {
            font-size: 85px;
        }

        .file-input {
            width: 200px;
            margin: auto;
            height: 68px;
            position: relative;

            label,
            input {
                background: #fff;
                color: #2196F3;
                width: 100%;
                position: absolute;
                left: 0;
                top: 0;
                padding: 10px;
                border-radius: 4px;
                margin-top: 7px;
                cursor: pointer;
            }

            input {
                opacity: 0;
                z-index: -2;
            }
        }

        .images-preview {
            display: flex;
            flex-wrap: wrap;
            margin-top: 20px;

            .img-wrapper {
                width: 160px;
                display: flex;
                flex-direction: column;
                margin: 10px;
                height: 150px;
                justify-content: space-between;
                background: #fff;
                box-shadow: 5px 5px 20px #3e3737;

                img {
                    max-height: 105px;
                }
            }

            .details {
                font-size: 12px;
                background: #fff;
                color: #000;
                display: flex;
                flex-direction: column;
                align-items: self-start;
                padding: 3px 6px;

                .name {
                    overflow: hidden;
                    height: 18px;
                }
            }
        }

        .upload-control {
            position: absolute;
            width: 100%;
            background: #fff;
            top: 0;
            left: 0;
            border-top-left-radius: 7px;
            border-top-right-radius: 7px;
            padding: 10px;
            padding-bottom: 4px;
            text-align: right;

            button, label {
                background: #2196F3;
                border: 2px solid #03A9F4;
                border-radius: 3px;
                color: #fff;
                font-size: 15px;
                cursor: pointer;
            }

            label {
                padding: 2px 5px;
                margin-right: 10px;
            }
        }
    }
</style>
