<edit-form show={show}>
    <form action="#" class="mt-3">
        <div class="form-group">
            <label class="col-form-label">Title</label>
            <input type="text" id="title" class="form-control" placeholder="Enter title" onkeyup={inputTitle} value="{title}">
        </div>

        <div class="form-group">
            <label class="col-form-label">Content</label>
            <textarea id="content" class="form-control" rows="4" onkeyup={inputContent}>{content}</textarea>
        </div>

        <button type="submit" class="btn btn-primary" onclick={submit}>Submit</button>
    </form>

    <script>
        let self = this
        self.title = ''
        self.content = ''
        self.id = ''

        let localRoute = route.create()
        localRoute(function () {
            self.show = false
            self.update()
        })
        localRoute('edit/*', function (id) {
            self.show = true
            self.id = id
            self.getData(id)
        })

        inputTitle(e) {
            self.title = e.target.value
        }

        inputContent(e) {
            self.content = e.target.value
        }

        getData(id) {
            axios.get('http://api.arman.local/articles/'+id)
            .then(function (response) {
                self.title = response.data.title
                self.content = response.data.content
                self.update()
            })
            .catch(function (error) {
                console.log(error);
            });
        }

        submit(id) {
            let params = new URLSearchParams()
            params.append('_method', 'PATCH')
            params.append('title', self.title)
            params.append('content', self.content)
            axios.post('http://api.arman.local/articles/'+self.id+'?_method=PATCH', params)
            .then(function (response) {
                route('/')
            })
            .catch(function (error) {
                console.log(error);
            });
        }
    </script>
</edit-form>