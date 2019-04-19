<template>
    <div>
        <header-component></header-component>
        <body-component></body-component>
        <footer-component></footer-component>
    </div>
</template>
<script>
import header from './components/share/header'
import footer from './components/share/footer'
import body from './components/body'

export default {
  components: {
    'header-component': header,
    'footer-component': footer,
    'body-component': body
  }
}
</script>

<style scoped>
div{
    margin-top: -15px;
    margin-left:-5px;
    margin-right: -8px;
}
</style>
