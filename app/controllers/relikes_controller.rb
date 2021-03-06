class RelikesController < ApplicationController
    def likes_toggle
        relike = Relike.find_by(user_id: current_user.id, reply_id: params[:id])
        if relike.nil?
            Relike.create(user_id: current_user.id, reply_id: params[:id])
            
            # 인기 댓글 선정
            reply = Reply.find_by_id(params[:id])
            if (reply.relikes.size - reply.rehates.size) >=3 
                reply.hot =1
                reply.save
            end
            
        else
            relike.destroy
            # 인기 댓글 탈락
            reply = Reply.find_by_id(params[:id])
            if (reply.relikes.size - reply.rehates.size) < 3 
                reply.hot =0
                reply.save
            end
        end
        redirect_to :back
    end
end
