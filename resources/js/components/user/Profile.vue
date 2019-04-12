<template>
    <div class=" mt-5">
        <div class="jumbotron col-sm-8 mx-auto">
            <h1 class="text-center"> Profile</h1>
        </div>
        <table class="table col-md-6 mx-auto">
            <tbody>
            <tr>
                <td>Name</td>
                <td>{{name}}</td>
            </tr>
            <tr>
                <td>Email</td>
                <td>{{email}}</td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
    export default {
        name: "Profile",
        data(){
            const user = JSON.parse(window.localStorage.getItem('authUser'));
            return {
                id: user.id,
                name: user.name,
                email: user.email,
            }
        },
    }
</script>

<style scoped>

</style>
