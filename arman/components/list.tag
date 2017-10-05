<list show={show}>
    <style>
        .loader {
            border: 16px solid #f3f3f3; /* Light grey */
            border-top: 16px solid #3498db; /* Blue */
            border-radius: 50%;
            width: 80px;
            height: 80px;
            animation: spin 2s linear infinite;
            margin: 0 50%;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>

    <div class="loader" show={load}></div>

    <div class="table-responsive mt-4">
        <form action="#">
            <div class="form-row">
                <div class="col">
                    <label class="col-form-label">Filter By</label>
                    <select class="custom-select" onchange={filterby}>
                        <option value="title">Title</option>
                        <option value="content">Content</option>
                    </select>
                </div>

                <div class="col">
                    <label class="col-sm-2 float-left">Filter</label>
                    <input type="text" class="col-sm-4" onkeyup={changefilter}>
                </div>

                <div class="col">
                    <button class="btn btn-primary" onclick={getData}>Filter</button>
                </div>
            </div>
        </form>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>#</th>
                    <th id="title" onclick={order} style="cursor:pointer">Title</th>
                    <th id="created_at" onclick={order} style="cursor:pointer">Created Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr each={ a, i in articles }>
                    <td>{ (i + 1) + (take * skip) }</td>
                    <td>{ a.title }</td>
                    <td>{ a.created_at }</td>
                    <td>
                        <a class="btn btn-primary" href="#/show/{ a._id }">Show</a>
                        <a class="btn btn-warning" href="#/edit/{ a._id }">Edit</a>
                        <a class="btn btn-danger" id="{ a._id }" onclick={delete} style="cursor:pointer">Delete</a>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="text-center row">
            <div class="col">
                <button class="btn" disabled={ page == 0 } onclick={first}> &laquo; First </button>
                <button class="btn" disabled={ page == 0 } onclick={prev}> &lt; Prev </button>
            </div>

            <div class="col">
                <span>Page { page + 1 } / { Math.ceil(total / take) == 0 ? 1 : Math.ceil(total / take) }</span>
                <div class="form-group">
                <label class="col-form-label">Data per page : </label>
                <input class="form-control" type="number" value="20" onchange={change}>
                </div>
            </div>

            <div class="col">
                <button class="btn" disabled={ page == Math.floor(total / take) || total <= take } onclick={next}> Next &gt; </button>
                <button class="btn" disabled={ page == Math.floor(total / take) || total <= take } onclick={last}> Last &raquo; </button>
            </div>
        </div>
    </div>

    <script>
        let self = this
        self.page = 0
        self.total = 0
        self.take = 20
        self.skip = 0
        self.orderBy = 'created_at'
        self.filterValue = ''
        self.filterBy = 'title'
        self.articles = []
        self.load = true

        let localRoute = route.create()
        localRoute(function () {
            self.show = false
            self.update()
        })
        localRoute('/', function () {
            self.show = true
            self.getData()
        })

        filterby(e) {
            self.filterBy = e.target.value
        }

        changefilter(e) {
            self.filterValue = e.target.value
        }

        order(e) {
            self.orderBy = e.target.id
            self.getData()
        }

        change(e) {
            if (e.target.value > 0) {
                self.take = e.target.value
            }
            self.getData()
        }

        first() {
            self.page = 0
            self.skip = self.page
            self.getData()
        }

        prev() {
            if (self.page > 0) {
                self.page--
                self.skip = self.page
                self.getData()
            }
        }

        next() {
            if (self.page < Math.ceil(self.total / self.take) - 1) {
                self.page++
                self.skip = self.page
                self.getData()
            }
        }

        last() {
            self.page = Math.ceil(self.total / self.take) - 1
            self.skip = self.page
            self.getData()
        }

        getData() {
            self.articles = []
            self.load = true
            self.update()
            axios.get('https://139.59.113.184/public/arman-api/public/articles', {
                params: {
                    skip: self.skip,
                    take: self.take,
                    order_by: self.orderBy,
                    filter: self.filterValue,
                    filter_by: self.filterBy
                }
            })
            .then(function (response) {
                self.articles = response.data.data
                self.total = response.data.total
                self.take = response.data.per_page
                self.load = false
                self.update()
            })
            .catch(function (error) {
                console.log(error);
            });
        }

        delete(e) {
            axios.post('https://139.59.113.184/public/arman-api/public/articles/'+e.target.id+'?_method=DELETE')
            .then(function (response) {
                self.getData()
            })
            .catch(function (error) {
                console.log(error);
            });
        }

        self.getData()
    </script>
</list>
