<template>
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Manager wallet</h3>
        </div>
        <!-- /.card-header -->
        <div class="card-body">
            <div class="dataTables_wrapper dt-bootstrap4">
                <div class="row">
                    <div class="col-sm-12 col-md-6">

                    </div>
                    <div class="col-sm-12 col-md-6">

                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-bordered table-hover dataTable" role="grid">
                            <thead>
                            <tr role="row" class="alert-danger font-weight-bolder">
                                <th @click="sort('id')">
                                    STT &emsp;
                                    <button class="fa far fa-sort "></button>
                                </th>
                                <th @click="sort('name')">
                                    Name &emsp; &emsp; &emsp; &emsp;
                                    <button class="fa far fa-sort "></button>
                                </th>
                                <th @click="sort('cash')">
                                    Cash &emsp; &emsp; &emsp; &emsp; &emsp;
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th @click="sort('pay')">
                                    Current Money &emsp; &emsp;
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th>Modify</th>
                                <th>List Transaction</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr role="row" v-for="(wl,id) in orderbyWallets ">
                                <td>{{id}}</td>
                                <td>{{wl.name}}</td>
                                <td>{{ wl.cash | formatMoney}} {{wl.currency_name}}</td>
                                <td>{{wl.pay | formatMoney}} {{wl.currency_name}}</td>
                                <td class="hover">
                                    <button @click="EditModal(wl.id,id)">
                                        <i class="fa fa-edit blue"></i>
                                    </button>
                                    /
                                    <button @click="DeleteModal(wl.id,id)">
                                        <i class="fa fa-trash red"></i>
                                    </button>
                                </td>
                                <td align="center">
                                    <button @click="ListTransaction(wl.id)">
                                        <i class="fas fa-list blue"></i>
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <button class="btn btn-success" @click="NewModal">
                            <i class="fas fa-plus-circle">Add New</i>
                        </button>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-lg-auto">
                        <div class="dataTables_paginate paging_simple_numbers " id="example2_paginate">
                            <ul class="pagination">
                                <li class="paginate_button page-item previous disabled">
                                    <button class="" @click="prevPage">Previous</button>
                                </li>
                                <li class="paginate_button page-item current ">
                                    <button class="bg-blue border-primary">{{currentPage}} of {{totalPage}}</button>
                                </li>
                                <li class="paginate_button page-item next">
                                    <button class="" @click="nextPage">Next</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.card-body -->

        <!-- Modal add Wallet-->
        <div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add new wallet</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row justify-content-center">
                            <form action="./api/wallet" method="post" @submit.prevent="addWallet()" class="col-lg-6">
                                <ul class="list-group-item">
                                    <p>Tên Ví</p>
                                    <input class="item" name="name" v-model="name" type="text">
                                    <p class="red">{{errors.name}}</p>
                                    <p>Total {{cash}}</p>
                                    <input
                                            class="form-input input-lg"
                                            v-model="cash"
                                            v-money="money"
                                            style="text-align: right">
                                    <p class="red">{{errors.cash}}</p>
                                    <p>Currency</p>
                                    <select @change="getItem($event)">
                                        <option value="0">Choose Currency</option>
                                        <option v-for="curr in currencies" :value="curr.id">{{ curr.name }}
                                        </option>
                                    </select>
                                    <p class="red">{{errors.curency_id}}</p>
                                </ul>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Create</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal edit Wallet-->
        <div class="modal fade" id="EditWallet" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit wallet</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row justify-content-center">
                            <form action="./api/wallet" method="patch" @submit.prevent="EditWallet()" class="col-lg-7">
                                <ul class="list-group-item">
                                    <p>Tên Ví</p>
                                    <input class="item" name="name" v-model="name" type="text">
                                    <p class="red">{{errors.name}}</p>
                                    <p>Total</p>
                                    <input class="item" v-model="cash" type="number">{{currency_name}}
                                    <p class="red">{{errors.cash}}</p>
                                </ul>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Edit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Delete Wallet-->
        <div class="modal fade " id="deleteWallet" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <form @submit.prevent="deleteWallet()" class="">
                        <h5 class="list-group-item bg-danger">
                            Are you sure delete?
                        </h5>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-danger">Delete</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

    export default {
        components: {},
        data() {
            return {
                money: {
                    decimal: ',',
                    thousands: '.',
                    precision:0,
                    masked: false /* doesn't work with directive */
                },
                errors: {
                    name: '',
                    cash: '',
                    curency_id: ''
                },
                // for add
                n: 0,
                name: '',
                cash: '',
                currency_id: '',
                currency_name: '',
                currencies: [],
                //for show
                getValue: '',
                wallets: [],
                // valiable to sort
                currentSort: 'item',
                currentSortDir: 'asc',
                // valiable to paginate
                pageSize: 3,
                currentPage: 1,
                totalPage: 1,
                API: axios.create({
                    headers: {
                        'Authorization': 'Bearer ' + window.$cookies.get('token')
                    },
                    timeout: 999999
                })
            };
        },

        mounted() {
            this.getListWallet();
        },

        computed: {
            orderbyWallets: function () {
                return this.wallets.sort((a, b) => {
                    this.totalPage = Math.ceil(this.wallets.length / this.pageSize);
                    if (this.currentPage > this.totalPage) {
                        this.currentPage = this.totalPage;
                    }
                    let modifier = 1;
                    if (this.currentSortDir === 'desc') modifier = -1;
                    if (a[this.currentSort] < b[this.currentSort]) return -1 * modifier;
                    if (a[this.currentSort] > b[this.currentSort]) return 1 * modifier;
                    return 0;
                })

                // paginate for data
                    .filter((row, index) => {
                            let start = (this.currentPage - 1) * this.pageSize;
                            let end = this.currentPage * this.pageSize;
                            if (index >= start && index < end) return true;
                        }
                    );
            },
        },

        methods: {
            getItem(event) {
                this.currency_id = event.target.value;
            },

            // get currency
            getCurrency() {
                this.API.get('/api/currency').then((response) => {
                    this.currencies = response.data
                })
            },

            // add wallet
            NewModal() {
                this.currencies = [];
                this.name = '';
                this.cash = '';
                this.currency_id = '';
                this.errors.cash = '';
                this.errors.name = '';
                this.errors.curency_id = '';
                this.getCurrency();
                $('#addNew').modal('show');
            },

            addWallet() {
                if (window.$cookies.get('token')) {
                    this.currencies = [];
                    this.getCurrency();
                    this.errors.cash = '';
                    this.errors.name = '';
                    this.errors.curency_id = '';
                    let params = {
                        'name': this.name,
                        'cash': this.cash,
                        'curency_id': this.currency_id
                    };
                    console.log(params);
                    if (!this.name) {
                        this.errors.name = 'wallet name is require'
                    }
                    if (!this.cash) {
                        this.errors.cash = 'cash is require'
                    }
                    if (this.currency_id == 0) {
                        this.errors.curency_id = 'please choose currency'
                    }
                    if (!(this.errors.curency_id || this.errors.cash || this.errors.name)) {

                        this.API.post('/api/wallet', params)
                            .then((response) => {
                                const wl = response.data;
                                this.wallets.push(wl);
                            });
                        $('#addNew').modal('hide');
                    }
                } else {
                    alert('phien lam viec het han');
                    $('#addNew').modal('hide');
                    this.$router.push('/login');
                }
            },

            // Edit wallet
            EditModal(id, ID) {
                if (window.$cookies.get('token')) {
                    this.currencies = [];
                    this.getCurrency();
                    this.errors.cash = '';
                    this.errors.name = '';
                    this.n = ID + (this.currentPage - 1) * this.pageSize;
                    this.wallet_id = id;
                    this.API.get('/api/wallet/' + id)
                        .then((response) => {
                            this.name = response.data.name;
                            this.cash = response.data.cash;
                            this.currency_id = response.data.curency_id;
                            this.currency_name = response.data.currency_name;
                        });
                    $('#EditWallet').modal('show');

                } else {
                    alert('Phien lam viec qua han');
                    this.$router.push('/login');
                }
            },

            EditWallet() {
                if (window.$cookies.get('token')) {
                    this.errors.name = '';
                    this.errors.cash = '';
                    let params = {
                        'id': this.wallet_id,
                        'name': this.name,
                        'cash': this.cash,
                        'curency_id': this.currency_id
                    };
                    if (!this.name) {
                        this.errors.name = 'name is require'
                    }
                    if (!this.cash) {
                        this.errors.cash = 'cash is require'
                    }
                    if (!(this.errors.name || this.errors.cash)) {
                        this.API.patch('/api/wallet/' + this.wallet_id, params)
                            .then((response) => {
                                const wl = response.data;
                                this.wallets.splice(this.n, 1);
                                this.wallets.push(wl);
                            });
                        $('#EditWallet').modal('hide');
                    }
                } else {
                    alert(' Phien lam viec qua han');
                    $('#EditWallet').modal('hide');
                    this.$router.push('/login');
                }

            },
            DeleteModal(id, ID) {
                this.n = ID + (this.currentPage - 1) * this.pageSize;
                this.wallet_id = id;
                $('#deleteWallet').modal('show')
            },
            deleteWallet() {
                if (window.$cookies.get('token')) {
                    this.API.delete('/api/wallet/' + this.wallet_id);
                    this.wallets.splice(this.n, 1);
                    $('#deleteWallet').modal('hide')
                } else {
                    alert(' Phien lam viec qua han ');
                    this.$router.push('/login')
                }
            },

            ListTransaction(id) {
                this.$router.push({name: 'transactions', params: {id}})
            },

            // get list transaction in wallet
            getListWallet() {
                this.API.get('/api/wallet')
                    .then((response) => {
                        this.wallets = response.data;
                    })
            },

            // funtion to sort with asc or desc
            sort: function (s) {
                //if s == current sort, reverse
                if (s === this.currentSort) {
                    this.currentSortDir = this.currentSortDir === 'asc' ? 'desc' : 'asc';
                }
                this.currentSort = s;
            },

            // paginate
            nextPage() {
                if ((this.currentPage * this.pageSize) < this.wallets.length) {
                    this.currentPage++;
                }
            },

            prevPage() {
                if ((this.currentPage > 1)) {
                    this.currentPage--;
                }
            }
        },
    }
</script>

<style scoped>

</style>
