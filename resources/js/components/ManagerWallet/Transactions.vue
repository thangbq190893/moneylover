<template>
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Manager Transactions</h3>
            <div class=" card-tools row">
                <div class="col-md-4">
                    <select @change="getItemSearch($event)">
                        <option value="">All</option>
                        <option v-for="it in items"> {{it.name}}</option>
                    </select>
                </div>
                <!-- SEARCH FORM -->
                <form class="form-inline ml-3" action="./api/searchTransaction" method="post"
                      @submit.prevent="search()">
                    <div class="input-group input-group-sm">
                        <input class="form-control form-control-navbar" type="search" placeholder="Search"
                               aria-label="Search" v-model="getValue">
                        <div class="input-group-append">
                            <button class="btn btn-navbar" type="submit">
                                <i class="fa fa-search"></i>
                            </button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
        <!-- /.card-header -->
        <div class="card-body">
            <div class="dataTables_wrapper dt-bootstrap4">
                <div class="row justify-content-end ">
                    <div class="col-md-6 navbar float-right">
                        From:
                        <datetime class="nav-item" type="date" v-model="date.firstDate" format="yyyy-MM-dd"></datetime>
                        To:
                        <datetime class="nav-item" type="date" v-model="date.secondDate" format="yyyy-MM-dd"></datetime>
                        <button class="nav-item btn-success" @click="selectBetweenDate()">search Time</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-bordered table-hover" role="grid" v-if="!errors.search">
                            <thead class="thead-dark">
                            <tr role="row">
                                <th rowspan="1" colspan="1" class="navbar-header navbar-right" @click="sort('item')">
                                    Name
                                    <button class="fa far fa-sort "></button>
                                </th>
                                <th rowspan="1" colspan="1" class="navbar-header navbar-right" @click="sort('cost')">
                                    Cash
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th rowspan="1" colspan="1" class="navbar-header navbar-right" @click="sort('note')"
                                    style="width: 200px">
                                    Note
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th rowspan="1" colspan="1" class="navbar-header navbar-right" @click="sort('date')">
                                    Date
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th rowspan="1" colspan="1">Modify</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="table-success" role="row" v-for="(trs,id) in orderbyTransactions" v-if="trs.id">
                                <td rowspan="1" colspan="1">{{trs.item}}</td>
                                <td rowspan="1" colspan="1">{{trs.cost | formatMoney}} {{trs.currency_name}}</td>
                                <th v-if="trs.note.length < 18"> {{trs.note}}</th>
                                <th rowspan="1" colspan="1" v-if="trs.note.length >=18 ">
                                    {{trs.note.substring(0,18)+'...'}}
                                </th>
                                <th rowspan="1" colspan="1">{{trs.date}}</th>
                                <td rowspan="1" colspan="1">
                                    <button @click="editModal(trs.id,id)">
                                        <i class="fa fa-edit blue"></i>
                                    </button>
                                    /
                                    <button @click="deleteModal(trs.id,id)">
                                        <i class="fa fa-trash red"></i>
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <p class="red">{{errors.search}}</p>
                        <button class="btn btn-success" @click="NewTransaction">
                            <i class="fas fa-plus-circle">Add New</i>
                        </button>
                    </div>

                </div>
                <!--pagination-->
                <div class="row justify-content-center">
                    <div class="col-lg-auto">
                        <div class="dataTables_paginate paging_simple_numbers " id="example2_paginate">
                            <ul class="pagination">
                                <li class="paginate_button page-item previous disabled">
                                    <button @click="prevPage">Previous</button>
                                </li>
                                <li class="paginate_button page-item current">
                                    <button class="bg-blue border-primary">{{currentPage}} of {{totalPage}}</button>
                                </li>
                                <li class="paginate_button page-item next">
                                    <button @click="nextPage">Next</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /pagination -->
            </div>
        </div>
        <!-- /.card-body -->

        <!-- Modal add Transacstion-->
        <div class="modal fade" id="AddTrans" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add new transaction</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row justify-content-center">
                            <form action="./api/transaction" method="post" @submit.prevent="createTrans()"
                                  class="col-lg-6">
                                <ul class="list-group item">
                                    <p>Category</p>
                                    <select @change="getItem($event)">
                                        <option value="0">Please select Category</option>
                                        <option v-for="cat in categories" :value="cat.id">{{cat.name}}</option>
                                    </select>
                                    <p>Item</p>
                                    <select @change="getValueItem($event)">
                                        <option value="0">Please select Item</option>
                                        <option v-for="it in items" :value="it.id">{{it.name}}</option>
                                    </select>
                                    <p class="red"> {{errors.item_id}}</p>
                                    <p>Cost</p>
                                    <input class="form-input input-lg" v-model="cost" v-money="money"
                                           style=" text-align: left; padding-left: 10px">
                                    <p class="red">{{errors.cost}}</p>
                                    <p>Note</p>
                                    <textarea name="" cols="20" rows="4" class="item" v-model="note" type="text" style="padding-left: 10px"></textarea>
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
        <!--/add transaction -->

        <!-- Modal Edit Transacstion-->
        <div class="modal fade" id="EditTrans" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit transaction</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row justify-content-center">
                            <form method="patch" @submit.prevent="editTrans()"
                                  class="col-lg-6">
                                <ul class="list-group item">
                                    <p>Category</p>
                                    <select @change="getItem($event)">
                                        <option :value="category_id">Please choose category</option>
                                        <option v-for="cat in categories" :value="cat.id">{{cat.name}}</option>
                                    </select>
                                    <p>Item</p>
                                    <select @change="getValueItem($event)">
                                        <option :value="item_id">{{item_name}}</option>
                                        <option v-for="it in items" :value="it.id">{{it.name}}</option>
                                    </select>
                                    <p>cost</p>
                                    <input class="form-input input-lg" v-model="cost" v-money="money"
                                           style="text-align: right">
                                    <p class="red">{{errors.cost}}</p>
                                    <p class="red">{{errors.event}}</p>
                                    <p>note</p>
                                    <textarea name=""  cols="20" rows="4"class="item" v-model="note" type="text" style="padding-left: 10px;"></textarea>
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
        <!--/add transaction -->
        <!-- Modal Delete Transaction-->
        <div class="modal fade " id="deleteTransaction" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <form @submit.prevent="deleteTransaction()" class="">
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
        data() {
            return {
                money: {
                    decimal: ',',
                    thousands: '.',
                    precision: 0,
                    masked: false /* doesn't work with directive */
                },
                // errors
                errors: {
                    item_id: '',
                    cost: '',
                    search: ''
                },
                //add trans
                trans_id: '',
                cost: '',
                note: '',
                item_id: '',
                item_name: '',
                category_id: '',
                category_name: '',
                items: [],
                categories: [],
                // search
                getValue: '',
                date: {
                    firstDate: null,
                    secondDate: null,
                },
                // get list transaction
                transact: [],
                http: '/api/wallet/' + this.$route.params.id + '/transactions',
                // valiable to sort
                currentSort: 'item',
                currentSortDir: 'asc',
                // valiable to paginate
                n: 0,
                pageSize: 4,
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
            this.getListTransaction();
            this.getFullItem();
        },

        computed: {
            orderbyTransactions: function () {
                if (this.transact instanceof Array) {
                    return this.transact.sort((a, b) => {
                        this.totalPage = Math.ceil(this.transact.length / this.pageSize);
                        if (this.currentPage > this.totalPage) {
                            this.currentPage = this.totalPage;
                        }
                        let modifier = 1;
                        if (this.currentSortDir === 'desc') modifier = -1;
                        if (a[this.currentSort] < b[this.currentSort]) {
                            return -1 * modifier;
                        } else if (a[this.currentSort] > b[this.currentSort]) {
                            return modifier;
                        } else
                            return 0;
                    })
                        .filter((row, index) => {
                            let start = (this.currentPage - 1) * this.pageSize;
                            let end = this.currentPage * this.pageSize;
                            if (index >= start && index < end) return true;
                        });
                } else {
                    return [];
                }
            }
        },

        methods: {
            formatValue(newValue) {
                return newValue.toString().replace(/\./g, '');
            },

            // get list category
            getListCategory() {
                this.API.get('/api/category').then((response) => {
                    this.categories = response.data
                })
            },

            // get list transaction in wallet
            getListTransaction(url = this.http) {
                this.API.get(url)
                    .then((response) => {
                        this.transact = response.data;
                    })
            },

            // search transaction in wallet
            getFullItem() {
                this.items = '';
                this.API.get('/api/item')
                    .then((response) => {
                        this.items = response.data;
                    })
            },
            getItemSearch(event) {
                this.getValue = event.target.value;
            },
            search() {
                this.errors.search = '';
                let params = {
                    'search': this.getValue,
                    'walletId': this.$route.params.id
                };
                this.API.post('/api/searchTransaction', params)
                    .then((response) => {
                        if (response.data == 404) {
                            this.errors.search = 'No data found for keyword:' + this.getValue;
                        } else {
                            this.transact = response.data;
                            this.currentPage = 1;
                        }
                    })
                    .catch((error) => {

                    })
            },
            selectBetweenDate() {
                this.errors.search = '';
                this.transact = '';
                let params = {
                    'date1': this.date.firstDate,
                    'date2': this.date.secondDate,
                    'walletId': this.$route.params.id
                };
                this.API.post('/api/searchDate', params)
                    .then((response) => {
                        if (response.data == 404) {
                            this.errors.search = 'search no match!!!'
                        } else {
                            this.transact = response.data;
                        }
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
                if ((this.currentPage * this.pageSize) < this.transact.length) {
                    this.currentPage++;
                }
            },

            prevPage() {
                if ((this.currentPage > 1)) {
                    this.currentPage--;
                }
            },

            // add-transaction
            NewTransaction() {
                this.categories = [];
                this.items = [];
                this.cost = '';
                this.note = '';
                this.item_id = '';
                this.errors.item_id = '';
                this.errors.cost = '';
                this.getListCategory();
                if (window.$cookies.get('token')) {
                    $('#AddTrans').modal('show')
                } else {
                    alert("phien lam viec qua han");
                    this.$router.push('/login');
                }
            },

            getItem(event) {
                if (event.target.value == 0) {
                    this.items = '';
                } else {
                    this.item_id = event.target.value;
                    this.API.get('/api/category/' + event.target.value).then((response) => {
                        this.items = response.data;
                    });
                }
                this.item_id = 0;
            },

            getValueItem(event) {
                if (!this.items) {
                    this.item_id = 0;
                } else {
                    this.item_id = event.target.value
                }
            },

            createTrans() {
                this.errors.item_id = "";
                this.errors.cost = "";
                let params = {
                    wallet_id: this.$route.params.id,
                    item_id: this.item_id,
                    cost: this.formatValue(this.cost),
                    note: this.note,
                };
                if (this.item_id == 0) {
                    this.errors.item_id = "Item is required"
                }
                if (!this.cost) {
                    this.errors.cost = "Cost is required"
                }
                if (!(this.errors.item_id || this.errors.cost)) {
                    if (window.$cookies.get('token')) {
                        this.API.post('/api/transaction', params).then((response) => {
                            if (this.transact instanceof Array) {
                                this.transact.push(response.data);
                            }
                        });
                        $('#AddTrans').modal('hide');
                    } else {
                        alert("phien lam viec qua han");
                        $('#AddTrans').modal('hide');
                        this.$router.push('/login');
                    }
                }
            },

            // Update transaction
            editModal(trans_id, id) {
                if (window.$cookies.get('token')) {
                    this.categories = [];
                    this.getListCategory();
                    this.errors.cost = "";
                    this.n = id + (this.currentPage - 1) * this.pageSize;
                    this.trans_id = trans_id;
                    this.API.get('/api/transaction/' + trans_id)
                        .then((response) => {
                                this.category_id = response.data.category_id;
                                this.item_name = response.data.item;
                                this.item_id = response.data.item_id;
                                this.cost = response.data.cost;
                                this.note = response.data.note;
                                $('#EditTrans').modal('show');
                            }
                        )
                } else {
                    alert("phien lam viec qua han")
                    this.$router.push('/login')
                }
            },

            editTrans() {
                this.errors.cost = "";
                let params = {
                    wallet_id: this.$route.params.id,
                    item_id: this.item_id,
                    cost: this.formatValue(this.cost),
                    note: this.note,
                };
                if (this.cost == "") {
                    this.errors.cost = "Cost is required"
                }
                if (!(this.errors.cost)) {
                    if (window.$cookies.get('token')) {
                        this.API.patch('/api/transaction/' + this.trans_id, params).then((response) => {
                            const trs = response.data;
                            this.transact.splice(this.n, 1);
                            this.transact.push(trs);
                        });
                        $('#EditTrans').modal('hide');
                    } else {
                        alert("phien lam viec qua han");
                        $('#EditTrans').modal('hide');
                        this.$router.push('/login');
                    }
                }
            },

            // Delete transaction
            deleteModal(trans_id, id) {
                this.trans_id = trans_id;
                this.n = id + (this.currentPage - 1) * this.pageSize;
                $('#deleteTransaction').modal('show');
            },
            deleteTransaction() {
                if (window.$cookies.get('token')) {
                    this.API.delete('/api/transaction/' + this.trans_id)
                        .then((res) => {
                                this.transact.splice(this.n, 1);
                            }
                        );
                    $('#deleteTransaction').modal('hide');
                } else {
                    alert("phien lam viec qua han");
                    this.$router.push('/login');
                }
            }
        },

        watch: {
            '$route'(to, from) {
                this.wallet.ID = to.params.id;
                this.wallet.NAME = to.params.name;
                this.url = '/api/wallet/' + this.wallet.ID + '/transactions';
                this.getTransactions(this.url)
            },
            immediate: true,
        }
    }
</script>

<style scoped>
</style>
