<detail show={show}>
    <form class="mt-3">
        <div class="form-row">
            <label class="col-sm-2 float-left">Title</label>
            <div class="col-sm-8">
                {article.title}
            </div>
        </div>

        <div class="form-row">
            <label class="col-sm-2 float-left">Content</label>
            <div class="col-sm-8">
                {article.content}
            </div>
        </div>
    </form>

    <script>
        let self = this
        self.article = {
            title: '',
            content: ''
        }

        let localRoute = route.create()
        localRoute(function () {
            self.show = false
            self.update()
        })
        localRoute('show/*', function (id) {
            self.show = true
            self.getData(id)
        })

        getData(id) {
            axios.get('http://api.arman.local/articles/'+id)
            .then(function (response) {
                self.article = response.data
                self.update()
            })
            .catch(function (error) {
                console.log(error);
            });
        }
    </script>
</detail>