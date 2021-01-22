/**
 * @api {post} /api/repos Track new repository
 * @apiName PostRepo
 * @apiGroup Repo
 *
 * @apiParam {String} owner Repository's owner's username
 * @apiParam {String} name Repository's name
 *
 * @apiSuccess {List} new  List of users who have starred in this date range.
 * @apiSuccess {List} former  List of users who have unstarred in this date range.
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
 *     {
 *       "owner": "phoenixframework",
 *       "name": "phoenix"
 *     }
 */

/**
 * @api {get} /api/repos/:owner/:name/history?from=2020-11-20&to=2020-12-01 Get stargazer history
 * @apiName GetRepoStargazers
 * @apiGroup Repo
 *
 * @apiParam {queryParam} from  Beginning of a date range for the query, with the format YYYY-MM-DD.
 * @apiParam {queryParam} to  Beginning of a date range for the query, with the format YYYY-MM-DD.
 *
 * @apiSuccess {List} new  List of users who have starred in this date range.
 * @apiSuccess {List} former  List of users who have unstarred in this date range.
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
 *     {
 *       "new": []
 *       "former": []
 *     }
 */
