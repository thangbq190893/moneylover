<template>
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Manager Transactions</h3>
            <div class=" card-tools">
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
            <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                <div class="row">
                    <div class="col-sm-12 col-md-6">

                    </div>
                    <div class="col-sm-12 col-md-6">

                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <table id="example2" class="table table-bordered table-hover dataTable" role="grid"
                               aria-describedby="example2_info">
                            <thead>
                            <tr role="row">
                                <th rowspan="1" colspan="1" class="navbar-header navbar-right" @click="sort('item')">
                                    Name
                                    <button class="fa far fa-sort "></button>
                                </th>
                                <th rowspan="1" colspan="1" class="navbar-header navbar-right" @click="sort('cost')">
                                    Cash
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th rowspan="1" colspan="1" class="navbar-header navbar-right" @click="sort('event')">
                                    Event
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th rowspan="1" colspan="1" class="navbar-header navbar-right" @click="sort('note')">
                                    Note
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th rowspan="1" colspan="1" class="navbar-header navbar-right"
                                    @click="sort('with_people')">With People
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
                            <tr role="row" v-for="(trs,id) in orderbyTransactions ">
                                <td rowspan="1" colspan="1">{{trs.item}}</td>
                                <td rowspan="1" colspan="1">{{trs.cost}} {{trs.currency_name}}</td>
                                <th rowspan="1" colspan="1">{{trs.event}}</th>
                                <th rowspan="1" colspan="1">{{trs.note}}</th>
                                <th rowspan="1" colspan="1">{{trs.with_people}}</th>
                                <th rowspan="1" colspan="1">{{trs.date}}</th>
                                <td rowspan="1" colspan="1">
                                    <a @click="editTransaction(trs.id,id)">
                                        <i class="fa fa-edit blue"></i>
                                    </a> /
                                    <a @click="deleteTransaction(trs.id,id)">
                                        <i class="fa fa-trash red"></i>
                                    </a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
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
                                <li class="paginate_button page-item previous disabled" id="example2_previous">
                                    <button @click="prevPage">Previous</button>
                                </li>
                                <li class="paginate_button page-item active">
                                    <a href="#" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">{{currentPage}}</a>
                                </li>
                                <li class="paginate_button page-item next" id="example2_next">
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
                                    <p>category</p>
                                    <select @change="getItem($event)">
                                        <option value="0">Please select Category</option>
                                        <option v-for="cat in categories" :value="cat.id">{{cat.name}}</option>
                                    </select>
                                    <p>item_id</p>
                                    <select @change="getValueItem($event)">
                                        <option v-for="it in items" :value="it.id">{{it.name}}</option>
                                    </select>
                                    <p>cost</p>
                                    <input class="item" v-model="cost" type="number">
                                    <p>event</p>
                                    <input class="item" v-model="event" type="text">
                                    <p>note</p>
                                    <input class="item" v-model="note" type="text">
                                    <p>with people </p>
                                    <input class="item" v-model="with_people" type="text">
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
                                    <p>category</p>
                                    <select @change="getItem($event)">
                                        <option value="0">Please select Category</option>
                                        <option v-for="cat in categories" :value="cat.id">{{cat.name}}</option>
                                    </select>
                                    <p>Item</p>
                                    <select @change="getValueItem($event)">
                                        <option v-for="it in items" :value="it.id">{{it.name}}</option>
                                    </select>
                                    <p>cost</p>
                                    <input class="item" v-model="cost" type="number">
                                    <p>event</p>
                                    <input class="item" v-model="event" type="text">
                                    <p>note</p>
                                    <input class="item" v-model="note" type="text">
                                    <p>with people </p>
                                    <input class="item" v-model="with_people" type="text">
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
    </div>
</template>

<script>

    export default {
        components: {
        },
        data() {
            return {
                //add trans
                event: "",
                cost: "",
                note: "",
                with_people: "",
                item_id: "",
                item_name: "",
                category_id: "",
                items: [],
                categories: [],
                getValue: '',
                transact: [],
                http: '/api/wallet/' + this.$route.params.id + '/transactions',
                // valiable to sort
                currentSort: 'item',
                currentSortDir: 'asc',
                // valiable to paginate
                n: 0,
                pageSize: 3,
                currentPage: 1,
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
            this.getListCategory();
        },
        computed: {
            orderbyTransactions: function () {
                if (this.transact instanceof Array){
                    return this.transact.sort((a, b) => {
                        let modifier = 1;
                        if (this.currentSortDir === 'desc') modifier = -1;
                        if (a[this.currentSort] < b[this.currentSort]){
                            return -1 * modifier;
                        } else if (a[this.currentSort] > b[this.currentSort]){
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
                        console.log(this.transact)
                    })
            },
            // search transaction in wallet
            search() {
                var params = {
                    'search': this.getValue,
                    'walletId': this.$route.params.id
                };
                this.API.post('/api/searchTransaction', params)
                    .then((response) => {
                        this.transact = response.data;
                        this.currentPage = 1;
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
                $('#AddTrans').modal('show')
            },
            getItem(event) {
                this.item_id = event.target.value;
                this.API.get('/api/category/' + event.target.value).then((response) => {
                    this.items = response.data
                });
            },
            getValueItem(event) {
                this.item_id = event.target.value
            },
            createTrans() {
                var params = {
                    wallet_id: this.$route.params.id,
                    item_id: this.item_id,
                    event: this.event,
                    cost: this.cost,
                    note: this.note,
                    with_people: this.with_people
                };
                if (window.$cookies.get('token')){
                    this.API.post('/api/transaction', params).then((response) => {
                        if (this.transact instanceof Array){
                            console.log('mảng hiện tại if',this.transact, this.transact.length);
                            this.transact.push(response.data);
                            console.log('Dữ liệu sau khi thêm if',this.transact, this.transact.length);
                        }
                        else {
                            console.log('mảng hiện tại else',this.transact);
                            this.transact.push(response.data);
                            console.log('mảng đã thêm else',this.transact, this.transact.length);
                        }
                    });
                    $('#AddTrans').modal('hide');
                } else {
                    alert("phien lam viec qua han")
                }

            },
            // Update transaction
            editTransaction(trans_id, id) {
                this.API.get('/api/transaction/' + trans_id)
                    .then((response) => {
                            this.item_name = response.data.item;
                            this.cost = response.data.cost;
                            this.note = response.data.note;
                            this.event = response.data.event;
                            this.with_people = response.data.with_people;
                            console.log(this.item_name, this.cost, this.note, this.event, this.with_people)
                        }
                    )
            },
            // Delete transaction
            deleteTransaction(trans_id, id) {
                this.n = id + (this.currentPage - 1) * this.pageSize;
                this.API.delete('/api/transaction/' + trans_id)
                    .then((res) => {
                        this.transact.splice(this.n);
                        alert(res.data.Delete)
                })
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
