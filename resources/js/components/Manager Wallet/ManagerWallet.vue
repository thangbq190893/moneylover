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
                                <th  @click="sort('name')">
                                    Name &emsp; &emsp; &emsp; &emsp;
                                    <button class="fa far fa-sort "></button>
                                </th>
                                <th  @click="sort('cash')">
                                    Cash &emsp; &emsp; &emsp; &emsp; &emsp;
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th  @click="sort('pay')">
                                    Current Money &emsp; &emsp;
                                    <button class="fa far fa-sort"></button>
                                </th>
                                <th >Modify</th>
                                <th >List Transaction </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr role="row" v-for="(wl,id) in orderbyWallets ">
                                <td >{{id}}</td>
                                <td >{{wl.name}}</td>
                                <td >{{ wl.cash  | formatMoney}} {{wl.currency_name}}</td>
                                <td >{{wl.pay | formatMoney}} {{wl.currency_name}}</td>
                                <td class="hover">
                                    <button @click="EditModal(wl.id,id)">
                                        <i class="fa fa-edit blue"></i>
                                    </button> /
                                    <button @click="DeleteWallet(wl.id,id)">
                                        <i class="fa fa-trash red"></i>
                                    </button>
                                </td>
                                <td >
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
                                    <p>Total</p>
                                    <input class="item" v-model="cash" type="number">
                                    <p>Currency</p>
                                    <select @change="getItem($event)">
                                        <option value="">Choose Currency</option>
                                        <option v-for="curr in currency" :value="curr.id">{{ curr.name }}
                                        </option>
                                    </select>
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
                            <form action="./api/wallet" method="patch" @submit.prevent="EditWallet()" class="col-lg-6">
                                <ul class="list-group-item">
                                    <p>Tên Ví</p>
                                    <input class="item" name="name" v-model="name" type="text">
                                    <p>Total</p>
                                    <input class="item" v-model="cash" type="number">
                                    <p>Currency</p>
                                    <select @change="getItem($event)">
                                        <option value="" disabled>{{ currency_name }}</option>
                                        <option v-for="curr in currency" :value="curr.id">{{ curr.name }}
                                        </option>
                                    </select>
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
    </div>
</template>

<script>

    export default {
        components: {
        },
        data() {
            return {
                // for add
                n: 0,
                name: "",
                cash: "",
                currency_id: "",
                currency_name: "",
                currency: [],
                //for show
                getValue: '',
                wallets: [],
                // valiable to sort
                currentSort: 'item',
                currentSortDir: 'asc',
                // valiable to paginate
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
            this.getListWallet();
            this.getCurrency();
        },
        computed: {
            orderbyWallets: function () {
                return this.wallets.sort((a, b) => {
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
            getItem(event){
                this.currency_id = event.target.value;
            },
            // get currency
            getCurrency() {
                this.API.get('/api/currency').then((response) => {
                    this.currency = response.data
                })
            },
            // add wallet
            addWallet() {
                var params = {
                    "name": this.name,
                    "cash": this.cash,
                    "curency_id": this.currency_id
                };
                this.API.post('/api/wallet', params)
                    .then((response) => {
                        const wl = response.data;
                        this.wallets.push(wl);
                    });
                $('#addNew').modal('hide');
            },
            // Edit wallet
            EditWallet() {
                this.wallets.splice(this.n, 1);
                var params = {
                    "id": this.wallet_id,
                    "name": this.name,
                    "cash": this.cash,
                    "curency_id": this.currency_id
                };
                this.API.patch('/api/wallet/' + this.wallet_id, params)
                    .then((response) => {
                        const wl = response.data;
                        this.wallets.push(wl);
                    });
                $('#EditWallet').modal('hide');
            },
            DeleteWallet(id, ID) {
                this.API.delete('/api/wallet/' + id);
                console.log(ID+(this.currentPage-1)*this.pageSize);
                this.wallets.splice(ID+(this.currentPage-1)*this.pageSize, 1);
            },
            ListTransaction(id) {
                this.$router.push({name: 'transactions',params: {id}})
            },
            // get list transaction in wallet
            getListWallet() {
                this.API.get('/api/wallet')
                    .then((response) => {
                        this.wallets = response.data;
                    })
            },
            NewModal() {
                $('#addNew').modal('show');
            },
            EditModal(id, ID) {
                this.n = ID;
                this.wallet_id = id;
                this.API.get('/api/wallet/' + id)
                    .then((response) => {
                        this.name = response.data.name;
                        this.cash = response.data.cash;
                        this.currency_id = response.data.curency_id;
                        this.currency_name = response.data.currency_name;
                    });
                $('#EditWallet').modal('show');

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
        }
        ,
        watch: {}
    }
</script>

<style scoped>

</style>
